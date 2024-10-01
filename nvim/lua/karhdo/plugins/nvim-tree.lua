-- Folder explorer
local M = {
	'nvim-tree/nvim-tree.lua',
	keys = {
		{ '<C-n>', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTreeToggle' }, -- Open/ Close
		{ '<leader>n', '<cmd>NvimTreeFindFile<cr>', desc = 'NvimTreeFindFile' }, -- Search File
	},
}

function M.config()
	local icons = require('karhdo.core.styles').icons
	local nvimtree = require('nvim-tree')

	-- Recommended settings from nvim-tree documentation
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	icons = {
		info = icons.info,
		hint = icons.hint,
		error = icons.error,
		warning = icons.warn,
	}

	nvimtree.setup({
		auto_reload_on_write = false,
		git = {
			enable = true,
			ignore = false,
			timeout = 500,
		},
		diagnostics = {
			enable = true,
			icons = icons,
		},
		view = {
			width = {
				min = 35,
				max = '40%',
			},
			side = 'right',
		},
		renderer = {
			add_trailing = false,
			group_empty = true,
			highlight_opened_files = 'name',
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						-- arrow_closed = '',
						-- arrow_open = '',
					},
				},
			},
		},
	})
end

return M
