---@type LazyPluginSpec
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
	local langs = { "lua", "typescript", "javascript" }

	require("nvim-treesitter.configs").setup({
    modules = {},
    ignore_install = {},
    sync_install = false,
    auto_install = false,
		ensure_installed = langs,
		highlight = {
			enable = not vim.g.vscode,
			additional_vim_regex_highlighting = { "org" },
		},
		indent = { enable = true },
		autotag = { enable = true },
	})
end

return M
