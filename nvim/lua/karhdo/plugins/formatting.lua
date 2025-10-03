local M = {
	'stevearc/conform.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
}

M.config = function()
	local conform = require('conform')

	conform.setup({
		formatters_by_ft = {
			javascript = { 'prettierd' },
			typescript = { 'prettierd' },
			javascriptreact = { 'prettierd' },
			typescriptreact = { 'prettierd' },
			css = { 'prettierd' },
			html = { 'prettierd' },
			json = { 'prettierd' },
			yaml = { 'prettierd' },
			markdown = { 'prettierd' },
			graphql = { 'prettierd' },
			liquid = { 'prettierd' },
			lua = { 'stylua' },
			python = { 'black' },
		},

		formatters = {
			prettierd = {
				env = {
					PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('~/.config/prettier/prettier.config.js'),
				},
			},
		},
	})

	vim.keymap.set({ 'n', 'v' }, '<leader><leader>f', function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 2000,
		})
	end, { desc = 'Format file or range (in visual mode)' })
end

return M
