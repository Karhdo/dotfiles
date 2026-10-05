local M = {
	'ibhagwan/fzf-lua',
	enabled = not vim.g.vscode,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
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
	'.kotlin',
	'.idea',
	'.cache',
	'coverage',
	'__pycache__',
	'.venv',
	'venv',
	'.claude',
}

-- Files no picker should list: lockfiles and binaries (DB dumps, archives, compiled output).
local ignore_files = {
	'*.lock',
	'*-lock.json',
	'.DS_Store',
	'*.dump',
	'*.jar',
	'*.class',
	'*.zip',
	'*.gz',
	'*.tgz',
	'*.tar',
	'*.so',
	'*.dylib',
	'*.exe',
}

-- Excluded inside fd/rg so they are never walked; fzf-lua's own
-- file_ignore_patterns would filter in Lua after the fact, which is the slow path.
local fd_opts = { '--color=never', '--type f', '--type l', '--hidden', '--no-ignore' }
-- --max-filesize is not optional: --no-ignore drags in gitignored logs/dumps.
local rg_opts = {
	'--column',
	'--line-number',
	'--no-heading',
	'--color=always',
	'--smart-case',
	'--hidden',
	'--no-ignore',
	'--max-filesize=1M',
	'--max-columns=300',
}
for _, dir in ipairs(ignore_dirs) do
	table.insert(fd_opts, '--exclude ' .. dir)
	table.insert(rg_opts, "--glob '!**/" .. dir .. "/**'")
end
for _, glob in ipairs(ignore_files) do
	table.insert(fd_opts, "--exclude '" .. glob .. "'")
	table.insert(rg_opts, "--glob '!" .. glob .. "'")
end
-- rg_opts must end with -e: fzf-lua appends the query right after it.
table.insert(rg_opts, '-e')

function M.config()
	local fzf = require('fzf-lua')
	local border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }

	fzf.setup({
		winopts = {
			width = 0.7,
			border = border,
			preview = { border = border },
		},
		fzf_opts = { ['--layout'] = 'reverse' },
		previewers = {
			builtin = { syntax_limit_b = 1024 * 1024 },
		},
		files = {
			prompt = '🔍 ',
			cwd_prompt = false,
			git_icons = false,
			fd_opts = table.concat(fd_opts, ' '),
		},
		grep = {
			prompt = '🔍 ',
			git_icons = false,
			rg_opts = table.concat(rg_opts, ' '),
		},
		oldfiles = { cwd_only = true },
	})

	local keymap = vim.keymap
	keymap.set('n', ';f', fzf.files, { desc = 'Fuzzy find files in cwd' })
	keymap.set('n', ';r', fzf.oldfiles, { desc = 'Fuzzy find recent files' })
	keymap.set('n', ';s', fzf.live_grep, { desc = 'Find string in cwd' })
	keymap.set('n', ';c', fzf.grep_cword, { desc = 'Find string under cursor in cwd' })
	keymap.set('n', ';b', fzf.buffers, { desc = 'Find find files in buffers' })
	-- fzf has no normal mode, so Esc closes the picker; this reopens it with the same query.
	keymap.set('n', ';;', fzf.resume, { desc = 'Resume last picker' })
end

return M
