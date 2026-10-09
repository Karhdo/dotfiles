-- Toggle comments (gc/gcc), with JSX/TSX-aware commentstrings.
return {
	'numToStr/Comment.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
	-- ts_context_commentstring registers itself as a nvim-treesitter *module*
	-- unless told otherwise. Modules only exist on nvim-treesitter's frozen
	-- `master`, so on `main` that path is dead weight (and deprecated upstream).
	init = function()
		vim.g.skip_ts_context_commentstring_module = true
	end,
	config = function()
		require('ts_context_commentstring').setup({})
		local ts_pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

		---@diagnostic disable-next-line: missing-fields
		require('Comment').setup({
			-- On Neovim 0.11+, `vim.treesitter.get_parser` returns nil (instead of
			-- erroring) when a buffer has no parser. Comment.nvim's own fallback
			-- doesn't guard against that and fails with "[Comment.nvim] nil", so
			-- fall back to the buffer's native `commentstring` before it runs.
			pre_hook = function(ctx)
				return ts_pre_hook(ctx) or vim.bo.commentstring
			end,
		})
	end,
}
