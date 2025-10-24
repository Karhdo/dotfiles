local M = {
	'numToStr/Navigator.nvim',
	keys = {
		{ '<C-h>', '<Cmd>NavigatorLeft<CR>', desc = 'Navigate Left' },
		{ '<C-k>', '<Cmd>NavigatorUp<CR>', desc = 'Navigate Up' },
		{ '<C-l>', '<Cmd>NavigatorRight<CR>', desc = 'Navigate Right' },
		{ '<C-j>', '<Cmd>NavigatorDown<CR>', desc = 'Navigate Down' },
	},
}

function M.config()
	require('Navigator').setup({
		auto_save = nil,
		disable_on_zoom = true,
	})
end

return M
