---@type LazyPlugin
local M = {
	"RRethy/vim-illuminate",
}

function M.config()
	require("illuminate").configure({
		filetypes_denylist = { "NvimTree" },
	})
end

return M
