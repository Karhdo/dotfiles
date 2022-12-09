return function()
	require("illuminate").configure({
		filetypes_denylist = { "NVimTree" },
	})
end
