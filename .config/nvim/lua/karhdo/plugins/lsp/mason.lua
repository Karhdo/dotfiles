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
			'kotlin_lsp',
		},
		-- jdtls is started by nvim-jdtls (see jdtls.lua), not mason-lspconfig
		automatic_enable = {
			exclude = { 'jdtls' },
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
