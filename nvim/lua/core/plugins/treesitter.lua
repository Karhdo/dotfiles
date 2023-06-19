---@type LazyPlugin
local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- We recommend updating the parsers on update
	dependencies = {
		"windwp/nvim-ts-autotag",
		"p00f/nvim-ts-rainbow",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
}

function M.config()
	local langs = { "lua", "typescript" }

	require("nvim-treesitter.configs").setup({
		ensure_installed = langs,
		highlight = {
			enable = not vim.g.vscode, -- false will disable the whole extension
			additional_vim_regex_highlighting = { "org" },
		},
		indent = { enable = true },
		autotag = { enable = true },
		rainbow = {
			enable = not vim.g.vscode, -- false will disable the whole extension
			disable = { "html" },
			extended = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false, --[[`false` for Comment.nvim]]
		},
	})
end

return M
