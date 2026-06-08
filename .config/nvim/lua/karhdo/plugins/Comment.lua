local M = {
	'numToStr/Comment.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'JoosepAlviste/nvim-ts-context-commentstring',
	},
}

function M.config()
	-- Import Comment plugin safely
	local Comment = require('Comment')

	local ts_context_commentstring = require('ts_context_commentstring.integrations.comment_nvim')
	local ts_pre_hook = ts_context_commentstring.create_pre_hook()

	-- On Neovim 0.11+/0.12, `vim.treesitter.get_parser` returns nil (instead of
	-- erroring) when a buffer has no parser. Comment.nvim's own fallback
	-- (`Comment.ft.calculate`) doesn't guard against that and crashes with a
	-- swallowed error shown as "[Comment.nvim] nil". By falling back to the
	-- buffer's native `commentstring` here, that broken fallback never runs.
	local function pre_hook(ctx)
		return ts_pre_hook(ctx) or vim.bo.commentstring
	end

	-- enable comment
  ---@diagnostic disable-next-line: missing-fields
	Comment.setup({
		-- for commenting tsx, jsx, svelte, html files
		pre_hook = pre_hook,
	})
end

return M
