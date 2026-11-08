-- Indent guides with an animated current scope, and smooth scrolling.
return {
	'folke/snacks.nvim',
	lazy = false, -- snacks hooks its modules in at startup and lazy-loads each one itself
	priority = 1000,
	opts = {
		indent = {
			indent = { char = '┊' },
			scope = { char = '┊' },
			-- Plugin windows already have a non-empty buftype; markdown is the only real file left out.
			filter = function(buf)
				return vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= 'markdown'
			end,
		},
		-- Scope textobjects (ii/ai) and jumps ([i/]i), as mini.indentscope had.
		scope = { enabled = true },
		scroll = { enabled = true },
	},
}
