-- Colorschemes: Tokyonight theme
local M = {
  "folke/tokyonight.nvim",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
	require("tokyonight").setup({
		style = "night",
	})

	require("tokyonight").load()
end

return M