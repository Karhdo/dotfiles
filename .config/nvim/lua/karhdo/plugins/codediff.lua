-- VSCode-style diff review: changes, history, PRs and merge conflicts.
-- The native diff library downloads on first use (`:CodeDiff install!` to
-- reinstall). Inside a diff tab: ]h/[h hunks, ]f/[f files, -/<leader>hS stage
-- file, <leader>hs/hu/hr stage/unstage/discard hunk, t toggle layout, g? help.
return {
	'esmuellert/codediff.nvim',
	enabled = not vim.g.vscode,
	cmd = 'CodeDiff',
	keys = {
		{ '<leader>gd', '<Cmd>CodeDiff<CR>', desc = 'Review git changes' },
		{ '<leader>gh', '<Cmd>CodeDiff history<CR>', desc = 'Repo commit history' },
		{ '<leader>gf', '<Cmd>CodeDiff history %<CR>', desc = 'Current file history' },
	},
	opts = {
		diff = {
			layout = 'side-by-side',
			compute_moves = true, -- Highlight moved blocks like VSCode's showMoves
		},
		explorer = {
			view_mode = 'tree',
			line_stats = { enabled = true }, -- +N -M per file and group
		},
		-- Mirror the gitsigns hunk keys so the same muscle memory works in both.
		keymaps = {
			view = {
				next_hunk = { ']h', ']c' },
				prev_hunk = { '[h', '[c' },
				toggle_stage = { '-', '<leader>hS' },
			},
		},
	},
}
