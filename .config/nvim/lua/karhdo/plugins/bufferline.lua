-- Buffer tabs along the top.
return {
	'akinsho/bufferline.nvim',
	event = 'VeryLazy',
	keys = {
		{ '<Tab>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
		{ '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
		{ '<leader>bcr', '<Cmd>BufferLineCloseRight<CR>', desc = 'Close buffers to the right' },
		{ '<leader>bcl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Close buffers to the left' },
		{ '<leader>bco', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Close other buffers' },
	},
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	opts = {
		options = {
			color_icons = true,
			diagnostics = 'nvim_lsp',
			left_mouse_command = 'buffer %d',
		},
	},
}
