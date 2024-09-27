local M = {
	'simrat39/symbols-outline.nvim',
	keys = {
		{ '<leader>to', '<Cmd>SymbolsOutline<CR>', desc = 'Toggle Symbols Outline' },
	},
}

function M.setup()
	require('symbols-outline').setup()
end

return M
