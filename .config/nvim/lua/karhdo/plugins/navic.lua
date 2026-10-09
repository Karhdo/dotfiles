-- LSP symbol context for the barbecue winbar.
return {
	'SmiteshP/nvim-navic',
	lazy = true, -- Loaded by barbecue
	opts = function()
		-- Same symbols as the completion menu; navic wants a trailing space.
		local icons = {}
		for kind, symbol in pairs(require('lspkind').presets.default) do
			icons[kind] = symbol .. ' '
		end

		return {
			highlight = true,
			separator = ' > ',
			icons = icons,
			depth_limit = 5,
		}
	end,
}
