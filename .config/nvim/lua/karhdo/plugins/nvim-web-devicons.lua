-- File-type icons, plus overrides for Angular-style `*.<kind>.ts` files.
return {
	'nvim-tree/nvim-web-devicons',
	lazy = true, -- Loaded by the plugins that list it as a dependency
	opts = function()
		local palette = require('karhdo.core.styles').palette

		return {
			default = true,
			override = {
				['component.ts'] = { icon = '', color = palette.dark_orange, name = 'TsComponent' },
				['directive.ts'] = { icon = '', color = palette.dark_blue, name = 'TsDirective' },
				['decorator.ts'] = { icon = '', color = palette.light_red, name = 'TsDecorator' },
				['guard.ts'] = { icon = '', color = palette.whitesmoke, name = 'TsGuard' },
				['module.ts'] = { icon = '📦', color = palette.light_yellow, name = 'TsModule' },
				['spec.ts'] = { icon = '', color = palette.green, name = 'TsTest' },
				['snippets'] = { icon = ' ', color = palette.green, name = 'Snippet' },
			},
		}
	end,
}
