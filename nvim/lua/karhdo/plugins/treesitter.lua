local M = {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufRead', 'BufNewFile' },
	build = ':TSUpdate', -- We recommend updating the parsers on update
	dependencies = {
		'windwp/nvim-ts-autotag',
	},
}

function M.config()
	local langs = {
		'lua',
		'typescript',
		'javascript',
	}

	local treesitter = require('nvim-treesitter.configs')

	-- Configure treesitter
	treesitter.setup({
		modules = {},
		ignore_install = {},
		sync_install = false,
		auto_install = false,
		ensure_installed = langs,
		indent = { enable = true },
		autotag = { enable = true },
		highlight = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-space>',
				node_incremental = '<C-space>',
				scope_incremental = false,
				node_decremental = '<bs>',
			},
		},
	})
end

return M
