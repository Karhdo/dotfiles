-- Animated guide for the indent scope under the cursor.
return {
	'echasnovski/mini.indentscope',
	version = '*',
	event = 'VeryLazy',
	init = function()
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('KarhdoIndentscope', { clear = true }),
			pattern = {
				'help',
				'lazy',
				'mason',
				'toggleterm',
				'lazyterm',
				'markdown',
				'NvimTree',
				'lspinfo',
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
	opts = {
		symbol = '┊',
		options = { try_as_border = true },
	},
}
