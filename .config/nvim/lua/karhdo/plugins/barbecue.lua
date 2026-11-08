-- Winbar breadcrumbs (file path > symbol), fed by nvim-navic.
return {
	'utilyre/barbecue.nvim',
	event = 'BufReadPost',
	dependencies = {
		'SmiteshP/nvim-navic',
		'nvim-mini/mini.icons',
	},
	opts = {
		exclude_filetypes = { 'gitcommit', 'toggleterm', 'Trouble' },
	},
}
