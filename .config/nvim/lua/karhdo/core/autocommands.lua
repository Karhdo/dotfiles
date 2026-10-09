local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
	return vim.api.nvim_create_augroup('Karhdo' .. name, { clear = true })
end

autocmd('TextYankPost', {
	group = augroup('YankHighlight'),
	callback = function()
		vim.hl.on_yank({ higroup = 'DiffText', on_visual = false })
	end,
})

-- Highlight matches only while typing a search, not after it.
local search = augroup('SearchHighlight')

autocmd('CmdlineEnter', {
	group = search,
	pattern = { '/', '?' },
	callback = function()
		vim.o.hlsearch = true
		vim.cmd.redrawstatus()
	end,
})

autocmd('CmdlineLeave', {
	group = search,
	pattern = { '/', '?' },
	callback = function()
		vim.o.hlsearch = false
		vim.cmd.redrawstatus()
	end,
})
