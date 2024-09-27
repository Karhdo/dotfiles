local M = {
	'nvim-telescope/telescope.nvim',
	enabled = not vim.g.vscode,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-media-files.nvim',
		'nvim-telescope/telescope-file-browser.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1 },
	},
}

function M.config()
	local telescope = require('telescope')
	local builtin = require('telescope.builtin')
	local sorters = require('telescope.sorters')

	local keymap = vim.keymap

	keymap.set('n', ';f', function()
		builtin.find_files({
			only_cwd = true,
			hidden = true,
			file_ignore_patterns = { '.git' },
		})
	end, { desc = 'Fuzzy find files in cwd' })

	keymap.set('n', ';r', ':Telescope oldfiles only_cwd=true<CR>', { desc = 'Fuzzy find recent files' })
	keymap.set('n', ';s', builtin.live_grep, { desc = 'Find string in cwd' })
	keymap.set('n', ';c', builtin.grep_string, { desc = 'Find string under cursor in cwd' })
	keymap.set('n', ';b', builtin.buffers, { desc = 'Find find files in buffers' })

	telescope.setup({
		defaults = {
			find_cmd = 'fd',
			path_display = { 'smart' },
			layout_config = {
				prompt_position = 'top',
				horizontal = { width = 0.7 },
			},
			sorting_strategy = 'ascending',
			file_ignore_patterns = { 'node_modules', 'dist', 'target' },
			file_sorter = sorters.get_fzy_sorter,
			prompt_prefix = '🔍 ',
			color_devicons = true,
			borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
		},
		extensions = {
			media_files = {
				filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
			},
		},
	})

	telescope.load_extension('fzf')
	telescope.load_extension('media_files')
	telescope.load_extension('file_browser')
end

return M
