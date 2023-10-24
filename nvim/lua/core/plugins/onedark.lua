-- Colorschemes: Onedark theme
local M = {
	"navarasu/onedark.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
	require("onedark").setup({
		--transparent = true,
		style = "darker",
		highlights = {
			SignColumn = { bg = "$bg0" },
			ColorColumn = { bg = "$bg0" },
			CursorLineNr = { fg = "$orange" },
			Terminal = { bg = "$bg0" },
			FoldColumn = { bg = "$bg1" },
			Folded = { bg = "$bg1" },
			GitSignsAdd = { bg = "$bg0" },
			GitSignsChange = { bg = "$bg0" },
			GitSignsDelete = { bg = "$bg0" },
			GitSignsStagedAdd = { fg = "$blue", bg = "$bg0" },
			GitSignsStagedChange = { fg = "$green", bg = "$bg0" },
			GitSignsStagedDelete = { fg = "$red", bg = "$bg0" },
			DiagnosticError = { bg = "$bg0" },
			DiagnosticWarn = { bg = "$bg0" },
			DiagnosticInfo = { bg = "$bg0" },
			DiagnosticHint = { bg = "$bg0" },
			DiagnosticVirtualTextError = { bg = "$none" },
			DiagnosticVirtualTextWarn = { bg = "$none" },
			DiagnosticVirtualTextInfo = { bg = "$none" },
			DiagnosticVirtualTextHint = { bg = "$none" },
			["@type.qualifier"] = { fg = "$purple" },
			["@storageClass"] = { fg = "$purple" },
			["@interface"] = { fg = "$yellow", fmt = "bold" },
			TSOperator = { fg = "$purple" },
			helpCommand = { fg = "$blue" },
			helpExample = { fg = "$blue" },
			jsonTSLabel = { fg = "$blue" },
		},
	})

  -- Remove comment to set onedark theme.
	-- require("onedark").load()
end

return M
