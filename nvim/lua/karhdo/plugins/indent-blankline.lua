-- Indent blankline
local M = {
	"lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
  enabled = true,
}

function M.config()
	require("ibl").setup({
		indent = {
			char = "┊",
			tab_char = "┊",
		},
    scope = { enabled = false },
		exclude = {
			filetypes = {
        "help",
        "lazy",
        "mason",
        "toggleterm",
        "lazyterm",
        "markdown",
        "NvimTree",
        "lspinfo",
      },
		},
	})
end

return M
