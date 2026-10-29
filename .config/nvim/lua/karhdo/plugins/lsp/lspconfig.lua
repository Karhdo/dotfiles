-- Per-server LSP config (vim.lsp.config). Servers are installed and enabled by
-- mason-lspconfig (mason.lua); keymaps and diagnostics live in core/lsp.lua.
return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'antosha417/nvim-lsp-file-operations',
	},
	config = function()
		-- Completion capabilities from cmp, plus willRename/didRename so servers can
		-- update imports when nvim-tree moves a file.
		vim.lsp.config('*', {
			capabilities = vim.tbl_deep_extend(
				'force',
				require('cmp_nvim_lsp').default_capabilities(),
				require('lsp-file-operations').default_capabilities()
			),
		})

		-- ts_ls advertises textDocument/inlayHint but ships every hint category
		-- switched OFF, so enabling hints on the client alone yields nothing.
		-- These preferences are what actually make it emit them.
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

		vim.lsp.config('ts_ls', {
			settings = {
				typescript = { inlayHints = ts_inlay_hints },
				javascript = { inlayHints = ts_inlay_hints },
			},
		})

		-- Pyright only sees the `python` on PATH, so it misses project venvs. Use the
		-- nearest `.venv` from the project root up (monorepos keep one per service, or
		-- one at the repo root), falling back to an activated $VIRTUAL_ENV.
		vim.lsp.config('pyright', {
			settings = {
				pyright = {
					-- ruff sorts imports (the `I` rules); two organize-imports actions conflict.
					disableOrganizeImports = true,
					-- Drop the "X is not accessed" hints; ruff already flags unused imports
					-- and variables (F401, F841), so they showed twice.
					disableTaggedHints = true,
				},
			},
			before_init = function(_, config)
				local venv = vim.fs.find('.venv', { path = config.root_dir, upward = true, type = 'directory' })[1]
					or vim.env.VIRTUAL_ENV
				local python = venv and venv .. '/bin/python'
				if python and vim.uv.fs_stat(python) then
					config.settings.python = vim.tbl_deep_extend('force', config.settings.python or {}, {
						pythonPath = python,
					})
				end
			end,
		})

		-- ruff (lint, import sort) runs next to pyright; leave hover to pyright, which
		-- shows types and docs instead of ruff's rule descriptions.
		vim.lsp.config('ruff', {
			on_attach = function(client)
				client.server_capabilities.hoverProvider = false
			end,
		})

		-- The stock root_dir falls back to `.git` (Tailwind v4 needs no config file), so
		-- the server started on every Markdown, HTML and JS file in any repo. Require a
		-- Tailwind/PostCSS config or a package.json that depends on Tailwind (v4 always does).
		vim.lsp.config('tailwindcss', {
			root_dir = function(bufnr, on_dir)
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
			end,
		})

		-- The server only starts in a dir with postgres-language-server.jsonc. Fall back
		-- to the git root so plain .sql files (e.g. Flyway migrations) still get syntax
		-- checks; a jsonc with a database connection adds schema-aware completion.
		vim.lsp.config('postgres_lsp', {
			root_markers = { 'postgres-language-server.jsonc', '.git' },
			workspace_required = false,
		})

		-- JetBrains Kotlin LSP is installed by hand, not by Mason (see mason.lua): builds are
		-- EAP and stop starting a few months after release, and the Mason registry lags behind.
		-- When it starts failing (exit code 7), unpack the newest standalone archive from
		-- github.com/Kotlin/kotlin-lsp/releases next to this one and bump the version here
		-- (and in that dir's mason-receipt.json, or Mason's "update all" tries to update it).
		local kotlin_lsp_home = vim.fn.stdpath('data') .. '/mason/packages/kotlin-lsp/kotlin-server-263.6379.0'
		local nvim_pid = tostring(vim.fn.getpid())
		local kotlin_lsp_owner_tag = 'NVIM_KOTLIN_LSP_OWNER=' .. nvim_pid
		vim.lsp.config('kotlin_lsp', {
			cmd = { kotlin_lsp_home .. '/bin/intellij-server', '--stdio' },
			cmd_env = { NVIM_KOTLIN_LSP_OWNER = nvim_pid },
			-- Nvim's default (false) never force-stops on quit; a server busy indexing ignores
			-- the polite shutdown and is left running. Kill it if it hasn't exited after 1s.
			exit_timeout = 1000,
		})
		vim.lsp.enable('kotlin_lsp')

		-- The server imports the project through a Gradle daemon (-Xmx8g). Daemons are built
		-- to outlive their client, so each nvim session left one burning ~1000% CPU. The
		-- daemon inherits the owner tag from the server's env; kill everything carrying it.
		vim.api.nvim_create_autocmd('VimLeavePre', {
			group = vim.api.nvim_create_augroup('KarhdoKotlinLspCleanup', { clear = true }),
			callback = function()
				for _, line in ipairs(vim.fn.systemlist({ 'ps', '-AEww', '-o', 'pid=,command=' })) do
					if line:find(kotlin_lsp_owner_tag .. '%f[^%d]') then
						vim.uv.kill(tonumber(line:match('^%s*(%d+)')), 'sigterm')
					end
				end
			end,
		})
	end,
}
