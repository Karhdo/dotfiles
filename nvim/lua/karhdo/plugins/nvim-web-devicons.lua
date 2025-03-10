local M = {
	'nvim-tree/nvim-web-devicons',
}

function M.config()
	local palette = require('karhdo.core.styles').palette
	local override = {
		['component.ts'] = {
			icon = '',
			color = palette.dark_orange,
			name = 'TsComponent',
		},
		['directive.ts'] = {
			icon = 'ﲔ',
			color = palette.dark_blue,
			name = 'TsDirective',
		},
		['decorator.ts'] = {
			icon = '',
			color = palette.light_red,
			name = 'TsDecorator',
		},
		['guard.ts'] = {
			icon = '',
			color = palette.whitesmoke,
			name = 'TsGuard',
		},
		['module.ts'] = {
			icon = '📦',
			color = palette.light_yellow,
			name = 'TsModule',
		},
		['spec.ts'] = {
			icon = '',
			color = palette.green,
			name = 'TsTest',
		},
		['snippets'] = {
			icon = ' ',
			color = palette.green,
			name = 'Snippet',
		},
	}

	require('nvim-web-devicons').setup({
		-- your personal icons can go here (to override)
		-- DevIcon will be appended to `name`
		-- override = vim.tbl_extend("keep",override ,devicons.get_icons()),
		override = override,
		-- globally enable default icons (default to false)
		-- will get overridden by `get_icons` option
		default = true,
	})
end

return M
