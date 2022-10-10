return function()
	require("nvim-tree").setup({
		auto_reload_on_write = false,
		view = { side = "right" },
	})

	-- Custom key maps
	local map = karhdo.map

	map("n", "<C-n>", ":NvimTreeToggle<CR>") -- open/close
	map("n", "<Leader>n", ":NvimTreeFindFile<CR>") -- search file
end
