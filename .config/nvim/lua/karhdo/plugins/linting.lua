local M = {
	'mfussenegger/nvim-lint',
	event = { 'BufReadPre', 'BufNewFile' },
}

M.config = function()
	local lint = require('lint')

	lint.linters_by_ft = {
		javascript = { 'codespell' },
		typescript = { 'codespell' },
		javascriptreact = { 'codespell' },
		typescriptreact = { 'codespell' },
	}

	local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

	vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set('n', '<leader>l', function()
		lint.try_lint()
	end, { desc = 'Trigger linting for current file' })
end

return M
