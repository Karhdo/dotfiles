--@type boolean
local not_has_vscode = not vim.g.vscode

--@type LazyPlugin[]
local M = {
	{ 'nvim-lua/plenary.nvim' },
	{ 'github/copilot.vim' },
	{
		'windwp/nvim-autopairs',
		event = { 'InsertEnter' },
		config = function()
			require('nvim-autopairs').setup()
		end,
	},
	-- {
	--   "williamboman/mason.nvim",
	--   enabled = not_has_vscode,
	--   config = function()
	--     require("mason").setup()
	--   end,
	-- },
	-- {
	--   "williamboman/mason-lspconfig.nvim",
	--   enabled = not_has_vscode,
	--   config = function()
	--     require("mason-lspconfig").setup()
	--   end,
	-- }
}

return M
