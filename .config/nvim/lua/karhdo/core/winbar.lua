local M = {}

function M.render()
	local name = vim.fn.expand('%:t')
	local icon, hl = require('mini.icons').get('file', name)
	local bar = ' %#' .. hl .. '#' .. icon .. '%* ' .. name:gsub('%%', '%%%%')

	local navic = require('nvim-navic')
	local location = navic.is_available() and navic.get_location() or ''
	if location ~= '' then
		bar = bar .. ' > ' .. location
	end

	return bar
end

return M
