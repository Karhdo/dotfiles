local M = {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
}

M.config = function()
	local conform = require('conform')

	conform.setup({
		formatters_by_ft = {
			javascript = { 'prettierd', extra_args = { '--config', 'prettier.config.js' } },
			typescript = { 'prettierd', extra_args = { '--config', 'prettier.config.js' } },
			javascriptreact = { 'prettierd', extra_args = { '--config', 'prettier.config.js' } },
			typescriptreact = { 'prettierd', extra_args = { '--config', 'prettier.config.js' } },
			css = { 'prettierd' },
			html = { 'prettierd' },
			json = { 'prettierd' },
			yaml = { 'prettierd' },
			markdown = { 'prettierd' },
			graphql = { 'prettierd' },
			liquid = { 'prettierd' },
			lua = { 'stylua' },
		},
	})

	vim.keymap.set({ 'n', 'v' }, '<leader><leader>f', function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		})
	end, { desc = 'Format file or range (in visual mode)' })
end

return M
