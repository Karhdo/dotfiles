-- Buffer explorer
local M = {
	"akinsho/bufferline.nvim",
	lazy = false,
	keys = {
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "BufferLineCycleNext" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "BufferLineCyclePrev" },
		{ "<Leader>bcr", "<Cmd>BufferLineCloseRight<CR>", desc = "BufferLineCloseRight" },
		{ "<Leader>bcl", "<Cmd>BufferLineCloseLeft<CR>", desc = "BufferLineCloseLeft" },
		{ "<Leader>bco", "<Cmd>BufferLineCloseLeft<CR><Cmd>BufferLineCloseRight<CR>", desc = "BufferLineCloseOther" },
	},
}

function M.config()
	require("bufferline").setup({
		options = {
			eft_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
			color_icons = true,
			diagnostics = "nvim_lsp",
		},
	})
end

return M
