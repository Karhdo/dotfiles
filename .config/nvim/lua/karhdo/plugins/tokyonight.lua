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
		on_highlights = function(hl, c)
			hl.DiagnosticUnnecessary = { fg = '#7882AD' }
			-- Error Lens-style tint for lines with a diagnostic (linehl in core/lsp.lua),
			-- fainter than the inline message's own background so that still stands out.
			local blend_bg = require('tokyonight.util').blend_bg
			hl.DiagnosticLineError = { bg = blend_bg(c.error, 0.06) }
			hl.DiagnosticLineWarn = { bg = blend_bg(c.warning, 0.06) }
			hl.DiagnosticLineInfo = { bg = blend_bg(c.info, 0.06) }
			hl.SnacksIndentScope = { fg = '#FFFFFF' }
		end,
	},
	config = function(_, opts)
		require('tokyonight').setup(opts)
		vim.cmd.colorscheme('tokyonight')
	end,
}
