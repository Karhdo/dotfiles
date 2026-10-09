-- Winbar breadcrumbs (file path > symbol), fed by nvim-navic.
return {
	'utilyre/barbecue.nvim',
	event = 'BufReadPost',
	dependencies = {
		'SmiteshP/nvim-navic',
		'nvim-tree/nvim-web-devicons',
	},
	opts = {
		exclude_filetypes = { 'gitcommit', 'toggleterm', 'Trouble' },
	},
}
