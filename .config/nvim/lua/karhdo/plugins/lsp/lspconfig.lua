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
