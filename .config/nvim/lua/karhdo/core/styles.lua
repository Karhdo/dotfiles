-- Shared look-and-feel constants. Plugins `require` this instead of repeating
-- glyphs and colors, so a change here applies everywhere.
return {
	icons = {
		-- Nerd Font v3 glyphs (v2-only codepoints render blank in WezTerm).
		diagnostics = {
			error = ' ',
			warn = ' ',
			info = ' ',
			hint = '󰠠 ',
		},
	},
	-- TODO: use other colors
	palette = {
		pale_red = '#E06C75',
		dark_red = '#be5046',
		light_red = '#c43e1f',
		dark_orange = '#FF922B',
		green = '#98c379',
		bright_yellow = '#FAB005',
		light_yellow = '#e5c07b',
		dark_blue = '#4e88ff',
		magenta = '#c678dd',
		comment_grey = '#5c6370',
		grey = '#3E4556',
		whitesmoke = '#626262',
		bright_blue = '#51afef',
		teal = '#15AABF',
	},
	border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
}
