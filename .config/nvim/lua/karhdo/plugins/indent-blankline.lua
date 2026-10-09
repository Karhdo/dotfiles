-- Indent guides. The current scope is drawn by mini.indentscope instead.
return {
	'lukas-reineke/indent-blankline.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	main = 'ibl',
	opts = {
		indent = {
			char = '┊',
			tab_char = '┊',
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				'help',
				'lazy',
				'mason',
				'toggleterm',
				'lazyterm',
				'markdown',
				'NvimTree',
				'lspinfo',
			},
		},
	},
}
