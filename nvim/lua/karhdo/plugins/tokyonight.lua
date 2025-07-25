-- Colorschemes: Tokyonight theme
local M = {
	'folke/tokyonight.nvim',
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
	local transparent = true -- set to true if you would like to enable transparency

	require('tokyonight').setup({
		style = 'night',
		styles = {
			sidebars = transparent and 'transparent' or 'dark',
			floats = transparent and 'transparent' or 'dark',
		},
		transparent = transparent,
		on_highlights = function(highlights)
			highlights.DiagnosticUnnecessary = { fg = '#7882AD' }
			highlights.MiniIndentscopeSymbol = { fg = '#FFFFFF' }
		end,
		on_colors = function(colors)
			colors.bg_dark = transparent and colors.none or 'dark'
			colors.bg_float = transparent and colors.none or 'dark'
			colors.bg_sidebar = transparent and colors.none or 'dark'
			colors.bg_statusline = transparent and colors.none or 'dark'
		end,
	})

	require('tokyonight').load()
end

return M
