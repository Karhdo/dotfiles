return function()
	require("lualine").setup({
		options = {
			theme = "tokyonight",
			disabled_filetypes = { "packer", "NVimTree" },
		},
	})
end
