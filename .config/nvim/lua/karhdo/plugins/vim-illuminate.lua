local M = {
	'RRethy/vim-illuminate',
}

function M.config()
	require('illuminate').configure({
		providers = { 'lsp', 'regex' },
		filetypes_denylist = { 'NvimTree' },
	})
end

return M
