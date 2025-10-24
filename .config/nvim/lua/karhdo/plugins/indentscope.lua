local M = {
	version = '*',
	event = 'VeryLazy',
	'echasnovski/mini.indentscope',
	init = function()
		vim.api.nvim_create_autocmd('FileType', {
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
}

function M.config()
	require('mini.indentscope').setup({
		symbol = '┊',
		options = { try_as_border = true },
	})
end

return M
