-- Highlight other uses of the word under the cursor.
return {
	'RRethy/vim-illuminate',
	event = { 'BufReadPost', 'BufNewFile' },
	opts = {
		providers = { 'lsp', 'regex' },
		filetypes_denylist = { 'NvimTree' },
	},
	-- Its entry point is configure(), not setup().
	config = function(_, opts)
		require('illuminate').configure(opts)
	end,
}
