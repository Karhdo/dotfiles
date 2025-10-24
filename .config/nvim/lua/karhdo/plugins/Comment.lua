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

	-- enable comment
  ---@diagnostic disable-next-line: missing-fields
	Comment.setup({
		-- for commenting tsx, jsx, svelte, html files
		pre_hook = ts_context_commentstring.create_pre_hook(),
	})
end

return M
