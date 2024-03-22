---@type LazyPluginSpec
local M = {
	"SmiteshP/nvim-navic",
}

function M.config()
    local kinds = require("core.global.style").lsp.kinds

	require("nvim-navic").setup({
		highlight = true,
		separator = " > ",
		icons = kinds,
		depth_limit = 5,
	})
end

return M
