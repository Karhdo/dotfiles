-- Indent blankline
local M = {
	"lukas-reineke/indent-blankline.nvim",
	lazy = false,
}

function M.config()
	require("indent_blankline").setup({
		show_end_of_line = true,
	})
end

return M
