-- Create the first autocommand group
local yank_group = vim.api.nvim_create_augroup('TextYankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			on_visual = false,
			higroup = 'DiffText',
		})
	end,
})

-- Create the second autocommand group
local search_group = vim.api.nvim_create_augroup('VimrcIncSearchHighlight', { clear = true })

vim.api.nvim_create_autocmd('CmdlineEnter', {
	group = search_group,
	pattern = '[/\\?]',
	command = [[:set hlsearch | redrawstatus]],
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
	group = search_group,
	pattern = '[/\\?]',
	command = ':set nohlsearch | redrawstatus',
})
