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
		-- kotlin_lsp is excluded because the Mason registry pins an expired EAP build. A newer
		-- one is unpacked by hand under ~/.local/share/nvim/mason/packages/kotlin-lsp/ and
		-- configured and enabled from lsp.lua.
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
