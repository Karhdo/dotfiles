local M = {
	'esmuellert/codediff.nvim',
	enabled = not vim.g.vscode,
	cmd = 'CodeDiff',
	keys = {
		{ '<leader>gd', '<cmd>CodeDiff<CR>', desc = 'Review git changes (CodeDiff)' },
		{ '<leader>gh', '<cmd>CodeDiff history<CR>', desc = 'Repo commit history (CodeDiff)' },
		{ '<leader>gf', '<cmd>CodeDiff history %<CR>', desc = 'Current file history (CodeDiff)' },
	},
}

-- The native diff library is downloaded on first use (`:CodeDiff install!` to
-- force a reinstall). Inside a diff tab: ]h/[h hunks, ]f/[f files, -/<leader>hS
-- stage file, <leader>hs/hu/hr stage/unstage/discard hunk, t toggle inline,
-- g? help.
M.config = function()
	require('codediff').setup({
		diff = {
			layout = 'side-by-side',
			-- Highlight moved blocks like VSCode's experimental showMoves.
			compute_moves = true,
		},
		explorer = {
			view_mode = 'tree',
			-- Show +N -M per file and per group.
			line_stats = { enabled = true },
		},
		-- Mirror the gitsigns hunk keys so the same muscle memory works in both.
		keymaps = {
			view = {
				next_hunk = { ']h', ']c' },
				prev_hunk = { '[h', '[c' },
				toggle_stage = { '-', '<leader>hS' },
			},
		},
	})
end

return M
