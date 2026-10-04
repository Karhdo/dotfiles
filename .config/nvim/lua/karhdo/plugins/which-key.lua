return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		-- Group labels shown in the popup after pressing <leader>.
		spec = {
			{ '<leader>h', group = 'git hunks (gitsigns)' },
			{ '<leader>g', group = 'git review (codediff)' },
		},
	},
}
