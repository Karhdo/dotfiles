local M = {
	'akinsho/toggleterm.nvim',
}

function M.config()
	local toggleterm = require('toggleterm')
	local border = require('karhdo.core.styles').border

	toggleterm.setup({
		open_mapping = [[<c-\>]],
		close_on_exit = true, -- Close the terminal window when the process exits
		shell = vim.o.shell, -- Change the default shell. Can be a string or a function returning a string
		float_opts = {
			border = border,
			highlight = {
				border = 'Normal',
				background = 'Terminal', -- Terminal | Normal
			},
		},
	})

	local keymap = vim.keymap

	local function set_terminal_keymaps(event)
		keymap.set('t', '<C-h>', '<C-\\><C-n><Cmd>lua require\'Navigator\'.left()<CR>', { buffer = event.buf })
		keymap.set('t', '<C-k>', '<C-\\><C-n><Cmd>lua require\'Navigator\'.up()<CR>', { buffer = event.buf })
		keymap.set('t', '<C-j>', '<C-\\><C-n><Cmd>lua require\'Navigator\'.down()<CR>', { buffer = event.buf })
		keymap.set('t', '<C-l>', '<C-\\><C-n><Cmd>lua require\'Navigator\'.right()<CR>', { buffer = event.buf })
	end

	vim.api.nvim_create_autocmd('TermOpen', {
		pattern = 'term://*',
		callback = set_terminal_keymaps,
	})

	local Terminal = require('toggleterm.terminal').Terminal

	local lazygit = Terminal:new({
		count = 8,
		cmd = 'lazygit',
		shade_terminals = false,
		direction = 'float',
		hidden = true,
		float_opts = { border = 'curved' },
		start_in_insert = true,
		on_open = function(term)
			keymap.set('t', '<C-q>', function()
				term:close()
			end, { buffer = term.bufnr })

			keymap.set('t', '<C-h>', '<C-h>', { buffer = term.bufnr })
			keymap.set('t', '<C-j>', '<C-j>', { buffer = term.bufnr })
			keymap.set('t', '<C-k>', '<C-k>', { buffer = term.bufnr })
			keymap.set('t', '<C-l>', '<C-l>', { buffer = term.bufnr })
		end,
	})

	local function lazygit_toggle()
		lazygit:toggle()
	end

	keymap.set('n', '<LocalLeader>gg', lazygit_toggle)
end

return M
