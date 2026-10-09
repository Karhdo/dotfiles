-- Linters via nvim-lint. Keep the tools in sync with mason-tool-installer
-- (lsp/mason.lua).
return {
	'mfussenegger/nvim-lint',
	event = { 'BufReadPre', 'BufNewFile' },
	keys = {
		{
			'<leader>l',
			function()
				require('lint').try_lint()
			end,
			desc = 'Lint current file',
		},
	},
	opts = {
		linters_by_ft = {
			javascript = { 'codespell' },
			typescript = { 'codespell' },
			javascriptreact = { 'codespell' },
			typescriptreact = { 'codespell' },
		},
	},
	-- nvim-lint has no setup(); it is configured by assigning fields.
	config = function(_, opts)
		local lint = require('lint')
		lint.linters_by_ft = opts.linters_by_ft

		vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
			group = vim.api.nvim_create_augroup('KarhdoLint', { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
