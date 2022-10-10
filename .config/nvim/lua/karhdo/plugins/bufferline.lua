return function()
	require("bufferline").setup({
		options = {
			left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
			color_icons = true,
			diagnostics = "nvim_lsp",
		},
	})

	-- Custom key maps
	local map = karhdo.map

	map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
	map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")
	map("n", "<Leader>bcr", "<Cmd>BufferLineCloseRight<CR>")
	map("n", "<Leader>bcl", "<Cmd>BufferLineCloseLeft<CR>")
end
