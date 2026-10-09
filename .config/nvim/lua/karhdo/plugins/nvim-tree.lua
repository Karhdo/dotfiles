-- File explorer, docked on the right.
return {
	'nvim-tree/nvim-tree.lua',
	keys = {
		{ '<C-n>', '<Cmd>NvimTreeToggle<CR>', desc = 'Toggle file explorer' },
		{ '<leader>n', '<Cmd>NvimTreeFindFile<CR>', desc = 'Reveal file in explorer' },
	},
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = function()
		local icons = require('karhdo.core.styles').icons.diagnostics

		return {
			auto_reload_on_write = false,
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
			diagnostics = {
				enable = true,
				icons = {
					error = vim.trim(icons.error),
					warning = vim.trim(icons.warn),
					info = vim.trim(icons.info),
					hint = vim.trim(icons.hint),
				},
			},
			view = {
				width = { min = 35, max = 35 },
				side = 'right',
			},
			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_opened_files = 'name',
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						folder = {
							arrow_closed = '',
							arrow_open = '',
						},
					},
				},
			},
		}
	end,
}
