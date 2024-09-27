local M = {
	'kylechui/nvim-surround',
	enabled = true,
	event = { 'CursorMoved' },
}

function M.config()
	require('nvim-surround').setup({})
end

return M
