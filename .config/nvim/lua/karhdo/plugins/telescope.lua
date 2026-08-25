local M = {
	'nvim-telescope/telescope.nvim',
	enabled = not vim.g.vscode,
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-media-files.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1 },
	},
}

-- Directories that must never show up in any picker. ';f' and ';s' pass
-- --no-ignore so .gitignore'd dotfiles stay searchable, which also drags in
-- dependencies and build output -- this list takes them back out.
local ignore_dirs = {
	'.git',
	'node_modules',
	'bower_components',
	'vendor',
	'dist',
	'build',
	'out',
	'target',
	'bin',
	'obj',
	'.next',
	'.nuxt',
	'.svelte-kit',
	'.turbo',
	'.gradle',
	'.idea',
	'.cache',
	'coverage',
	'__pycache__',
	'.venv',
	'venv',
	'.claude',
}

-- Lua patterns for telescope's own result filter. Anchored on path separators
-- so 'dist' does not also kill 'redistributable/'.
local file_ignore_patterns = { '%.lock$', '%-lock%.json$' }
for _, dir in ipairs(ignore_dirs) do
	local escaped = vim.pesc(dir)
	table.insert(file_ignore_patterns, '^' .. escaped .. '/')
	table.insert(file_ignore_patterns, '/' .. escaped .. '/')
end

-- fd args for find_files: cheaper to never walk these dirs than to filter after.
local find_command = { 'fd', '--type', 'f', '--hidden', '--no-ignore', '--strip-cwd-prefix' }
-- ripgrep args for live_grep, same idea.
local rg_ignore_args = {}
for _, dir in ipairs(ignore_dirs) do
	vim.list_extend(find_command, { '--exclude', dir })
	vim.list_extend(rg_ignore_args, { '--glob', '!**/' .. dir .. '/**' })
end

function M.config()
	local telescope = require('telescope')
	local builtin = require('telescope.builtin')
	local sorters = require('telescope.sorters')

	local keymap = vim.keymap

	keymap.set('n', ';f', function()
		builtin.find_files({
			only_cwd = true,
			hidden = true, -- include dotfiles
			no_ignore = true, -- include files listed in .gitignore
			find_command = vim.fn.executable('fd') == 1 and find_command or nil,
		})
	end, { desc = 'Fuzzy find files in cwd' })

	keymap.set('n', ';r', ':Telescope oldfiles only_cwd=true<CR>', { desc = 'Fuzzy find recent files' })
	keymap.set('n', ';s', function()
		builtin.live_grep({
			-- search dotfiles + gitignored files, minus the dirs above
			additional_args = vim.list_extend({ '--hidden', '--no-ignore' }, rg_ignore_args),
		})
	end, { desc = 'Find string in cwd' })
	keymap.set('n', ';c', builtin.grep_string, { desc = 'Find string under cursor in cwd' })
	keymap.set('n', ';b', builtin.buffers, { desc = 'Find find files in buffers' })

	telescope.setup({
		defaults = {
			path_display = { 'smart' },
			layout_config = {
				prompt_position = 'top',
				horizontal = { width = 0.7 },
			},
			sorting_strategy = 'ascending',
			-- Safety net: also drops anything the fd/rg args above missed
			-- (oldfiles, buffers, and any picker that does not shell out).
			file_ignore_patterns = file_ignore_patterns,
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
end

return M
