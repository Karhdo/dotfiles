-- Per-server LSP config (vim.lsp.config). Servers are installed, updated and enabled by
-- Mason (mason.lua); keymaps and diagnostics live in core/lsp.lua.

-- ts_ls advertises textDocument/inlayHint but ships every hint category switched OFF,
-- so enabling hints on the client alone yields nothing.
local ts_inlay_hints = {
	includeInlayParameterNameHints = 'all',
	includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = false,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

-- Pyright only sees the `python` on PATH. Use the nearest `.venv` from the project root
-- up (monorepos keep one per service, or one at the repo root), else $VIRTUAL_ENV.
local function use_project_venv(_, config)
	local venv = vim.fs.find('.venv', { path = config.root_dir, upward = true, type = 'directory' })[1]
		or vim.env.VIRTUAL_ENV
	local python = venv and venv .. '/bin/python'
	if python and vim.uv.fs_stat(python) then
		config.settings.python = vim.tbl_extend('force', config.settings.python or {}, { pythonPath = python })
	end
end

-- The stock root_dir falls back to `.git` (Tailwind v4 needs no config file), which
-- started the server in every repo. Require a Tailwind/PostCSS config or a package.json
-- that depends on Tailwind (v4 always does).
local function tailwind_root_dir(bufnr, on_dir)
	local fname = vim.api.nvim_buf_get_name(bufnr)
	local markers = require('lspconfig.util').insert_package_json({
		'tailwind.config.js',
		'tailwind.config.cjs',
		'tailwind.config.mjs',
		'tailwind.config.ts',
		'postcss.config.js',
		'postcss.config.cjs',
		'postcss.config.mjs',
		'postcss.config.ts',
	}, 'tailwindcss', fname)
	local found = vim.fs.find(markers, { path = fname, upward = true })[1]
	if found then
		on_dir(vim.fs.dirname(found))
	end
end

-- kotlin_lsp imports the project through a Gradle daemon (-Xmx8g). Daemons are built to
-- outlive their client, so each nvim session left one burning ~1000% CPU. Tag the server's
-- env with this nvim's pid (the daemon inherits it) and kill everything carrying it on quit.
local kotlin_owner = tostring(vim.fn.getpid())

local function kill_kotlin_processes()
	local tag = 'NVIM_KOTLIN_LSP_OWNER=' .. kotlin_owner .. '%f[^%d]'
	for _, line in ipairs(vim.fn.systemlist({ 'ps', '-AEww', '-o', 'pid=,command=' })) do
		if line:find(tag) then
			vim.uv.kill(tonumber(line:match('^%s*(%d+)')), 'sigterm')
		end
	end
end

local servers = {
	ts_ls = {
		settings = {
			typescript = { inlayHints = ts_inlay_hints },
			javascript = { inlayHints = ts_inlay_hints },
		},
	},
	pyright = {
		settings = {
			pyright = {
				-- ruff sorts imports (the `I` rules); two organize-imports actions conflict.
				disableOrganizeImports = true,
				-- ruff already flags unused imports and variables (F401, F841).
				disableTaggedHints = true,
			},
		},
		before_init = use_project_venv,
	},
	-- Runs next to pyright for lint and import sorting; pyright's hover shows types and
	-- docs, ruff's only rule descriptions.
	ruff = {
		on_attach = function(client)
			client.server_capabilities.hoverProvider = false
		end,
	},
	tailwindcss = { root_dir = tailwind_root_dir },
	-- Stock config only starts next to a postgres-language-server.jsonc. Fall back to the
	-- git root so plain .sql files (e.g. Flyway migrations) still get syntax checks.
	postgres_lsp = {
		root_markers = { 'postgres-language-server.jsonc', '.git' },
		workspace_required = false,
	},
	kotlin_lsp = {
		cmd_env = { NVIM_KOTLIN_LSP_OWNER = kotlin_owner },
		-- Nvim's default (false) never force-stops on quit; a server busy indexing ignores
		-- the polite shutdown. Kill it if it hasn't exited after 1s.
		exit_timeout = 1000,
	},
}

return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'antosha417/nvim-lsp-file-operations',
	},
	config = function()
		-- Completion capabilities from cmp, plus willRename/didRename so servers can update
		-- imports when nvim-tree moves a file.
		vim.lsp.config('*', {
			capabilities = vim.tbl_deep_extend(
				'force',
				require('cmp_nvim_lsp').default_capabilities(),
				require('lsp-file-operations').default_capabilities()
			),
		})

		for name, config in pairs(servers) do
			vim.lsp.config(name, config)
		end

		vim.api.nvim_create_autocmd('VimLeavePre', {
			group = vim.api.nvim_create_augroup('KarhdoKotlinLspCleanup', { clear = true }),
			callback = kill_kotlin_processes,
		})
	end,
}
