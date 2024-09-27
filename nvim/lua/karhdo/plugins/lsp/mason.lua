local M = {
	'williamboman/mason.nvim',
	dependencies = {
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',
	},
}

M.config = function()
	local mason = require('mason')
	local mason_lspconfig = require('mason-lspconfig')
	local mason_tool_installer = require('mason-tool-installer')

	-- Enable mason and configure icons
	mason.setup({
		ui = {
			icons = {
				package_pending = '➜',
				package_installed = '',
				package_not_installed = '',
			},
		},
	})

	mason_lspconfig.setup({
		-- List of servers for mason to install
		ensure_installed = {
			'ts_ls',
			'lua_ls',
			'eslint',
		},
	})

	mason_tool_installer.setup({
		ensure_installed = {
			'shfmt',
			'stylua',
			'prettierd',
			'stylelint',
			'codespell',
		},
	})
end

return M
