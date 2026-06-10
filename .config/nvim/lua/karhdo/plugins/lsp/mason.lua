return {
	'williamboman/mason-lspconfig.nvim',
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
		-- kotlin_lsp is NOT managed by Mason: the registry pins an expired EAP build that
		-- gets re-downloaded and clobbers our manual install. It's installed by hand under
		-- ~/.local/share/nvim/kotlin-lsp/ and enabled from lsp.lua instead.
		automatic_enable = {
			exclude = { 'jdtls', 'kotlin_lsp' },
		},
	},
	dependencies = {
		{
			'williamboman/mason.nvim',
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
				ensure_installed = {
					'shfmt',
					'stylua',
					'prettierd',
					'stylelint',
					'codespell',
					'black',
					'ruff',
					'google-java-format',
					'ktlint',
				},
			},
		},
		'neovim/nvim-lspconfig',
	},
}
