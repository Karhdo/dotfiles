-- Indent blankline
local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
	main = "ibl",
}

function M.config()
	require("ibl").setup({
		indent = {
			char = "│",
			tab_char = "│",
		},
		scope = { enabled = false },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	})
end

return M
