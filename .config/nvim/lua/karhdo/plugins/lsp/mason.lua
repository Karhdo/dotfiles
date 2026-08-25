return {
	'mason-org/mason-lspconfig.nvim',
	opts = {
		-- List of servers for mason to install
		ensure_installed = {
			'ts_ls',
			'html',
			'cssls',
			'tailwindcss',
			'lua_ls',
			'prismals',
			'pyright',
			'eslint',
			'jdtls',
		},
		-- jdtls is started by nvim-jdtls (see jdtls.lua), not mason-lspconfig.
		--
		-- kotlin_lsp is excluded so Mason never auto-installs it on startup. The build in
		-- ~/.local/share/nvim/mason/packages/kotlin-lsp/ has its `intellij-server` binary
		-- re-signed by hand so faketime can defeat the EAP time-bomb (see lsp.lua); any
		-- Mason (re)install replaces that binary with a stock-signed one and silently
		-- brings the expiry back. It is configured and enabled from lsp.lua instead.
		automatic_enable = {
			exclude = { 'jdtls', 'kotlin_lsp' },
		},
	},
	dependencies = {
		{
			'mason-org/mason.nvim',
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
					'black',
					'google-java-format',
					'ktlint',
				},
			},
		},
		'neovim/nvim-lspconfig',
	},
}
