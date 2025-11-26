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
			'gopls',
			'prismals',
			'pyright',
			'eslint',
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
				},
			},
		},
		'neovim/nvim-lspconfig',
	},
}
