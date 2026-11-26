-- Shared look-and-feel constants. Plugins `require` this instead of repeating
-- glyphs and borders, so a change here applies everywhere.
return {
	icons = {
		-- Nerd Font v3 glyphs (v2-only codepoints render blank in WezTerm).
		diagnostics = {
			error = ' ',
			warn = ' ',
			info = ' ',
			hint = '󰠠 ',
		},
	},
	border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
}
