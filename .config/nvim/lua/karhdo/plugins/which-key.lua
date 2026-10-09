-- Popup listing the keys that can follow a prefix. Name every new <leader>
-- prefix here so the popup labels it.
return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	opts = {
		spec = {
			{ '<leader>b', group = 'buffers' },
			{ '<leader>c', group = 'code / conflicts' },
			{ '<leader>g', group = 'git review (codediff)' },
			{ '<leader>h', group = 'git hunks (gitsigns)' },
			{ '<leader>s', group = 'splits' },
			{ ';', group = 'find (fzf-lua)' },
		},
	},
}
