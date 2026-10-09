-- Colorscheme. Loaded first so every other plugin picks up its highlights.
local transparent = true

return {
	'folke/tokyonight.nvim',
	lazy = false,
	priority = 1000,
	opts = {
		style = 'night',
		transparent = transparent,
		styles = {
			sidebars = transparent and 'transparent' or 'dark',
			floats = transparent and 'transparent' or 'dark',
		},
		on_colors = function(colors)
			if transparent then
				colors.bg_dark = colors.none
				colors.bg_float = colors.none
				colors.bg_sidebar = colors.none
				colors.bg_statusline = colors.none
			end
		end,
		on_highlights = function(hl)
			hl.DiagnosticUnnecessary = { fg = '#7882AD' }
			hl.MiniIndentscopeSymbol = { fg = '#FFFFFF' }
		end,
	},
	config = function(_, opts)
		require('tokyonight').setup(opts)
		vim.cmd.colorscheme('tokyonight')
	end,
}
