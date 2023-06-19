---@type LazyPlugin
local M = {
	"onsails/lspkind-nvim",
}

function M.config()
	local kinds = require("core.global.style").lsp.kinds

	require("lspkind").init({
		mode = "symbol_text",
		preset = "codicons",
		symbol_map = kinds,
	})
end

return M
