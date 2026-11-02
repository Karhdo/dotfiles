-- Installs LSP servers and tools, and enables the installed servers.
return {
	'mason-org/mason-lspconfig.nvim',
	-- Must run before the first buffer's FileType so its servers get enabled.
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{
			'mason-org/mason.nvim',
			cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate', 'MasonLog' },
			opts = {
				ui = {
					icons = {
						package_pending = '➜',
						package_installed = '',
						package_not_installed = '',
					},
				},
			},
		},
		{
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			opts = {
				-- Keep in sync with conform's `formatters_by_ft` (formatting.lua)
				-- and nvim-lint's `linters_by_ft` (linting.lua).
				ensure_installed = {
					'stylua',
					'prettierd',
					'codespell',
					'google-java-format',
					'ktlint',
					-- Not a formatter or linter here: bashls runs it for its diagnostics.
					'shellcheck',
					-- JetBrains' builds are EAP and refuse to start (exit code 7) a few
					-- months after release, so keep it on the newest one.
					{ 'kotlin-lsp', auto_update = true },
				},
				debounce_hours = 24, -- Check for that update at most once a day
			},
			config = function(_, opts)
				local installer = require('mason-tool-installer')
				installer.setup(opts)
				-- Its startup check hangs off VimEnter, which has already passed when nvim
				-- was started without a file and this loads on the first one opened.
				if vim.v.vim_did_enter == 1 then
					installer.run_on_start()
				end
			end,
		},
		'neovim/nvim-lspconfig',
	},
	opts = {
		ensure_installed = {
			'ts_ls',
			'html',
			'cssls',
			'tailwindcss',
			'lua_ls',
			'prismals',
			'pyright',
			'ruff',
			'eslint',
			'jdtls',
			'terraformls',
			'yamlls',
			'jsonls',
			'taplo',
			'bashls',
			'dockerls',
			'postgres_lsp',
			'texlab',
			'marksman',
		},
		-- jdtls is started by nvim-jdtls (jdtls.lua), not mason-lspconfig.
		automatic_enable = {
			exclude = { 'jdtls' },
		},
	},
}
