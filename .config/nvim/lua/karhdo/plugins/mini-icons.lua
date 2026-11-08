-- File-type icons, plus overrides for Angular-style `*.<kind>.ts` files.
return {
	'nvim-mini/mini.icons',
	version = '*',
	lazy = true, -- Loaded by the plugins that require nvim-web-devicons
	init = function()
		-- Plugins that only know nvim-web-devicons get mini.icons behind its API.
		package.preload['nvim-web-devicons'] = function()
			require('mini.icons').mock_nvim_web_devicons()
			return package.loaded['nvim-web-devicons']
		end
	end,
	opts = {
		extension = {
			['component.ts'] = { glyph = '', hl = 'MiniIconsOrange' },
			['directive.ts'] = { glyph = '', hl = 'MiniIconsBlue' },
			['decorator.ts'] = { glyph = '', hl = 'MiniIconsRed' },
			['guard.ts'] = { glyph = '', hl = 'MiniIconsGrey' },
			['module.ts'] = { glyph = '📦', hl = 'MiniIconsYellow' },
			['spec.ts'] = { glyph = '', hl = 'MiniIconsGreen' },
			['snippets'] = { glyph = '', hl = 'MiniIconsGreen' },
		},
	},
}
