local M = {
	'akinsho/toggleterm.nvim',
}

function M.config()
	local toggleterm = require('toggleterm')

	-- Pull the Tokyo Night palette for the float border color.
	local ok, tn = pcall(require, 'tokyonight.colors')
	local colors = ok and tn.setup() or {}
	local term_border = colors.blue or '#7aa2f7'

	toggleterm.setup({
		open_mapping = [[<c-\>]],
		close_on_exit = true, -- Close the terminal window when the process exits
		shell = vim.o.shell, -- Change the default shell. Can be a string or a function returning a string
		-- Height (horizontal split) / width (vertical) of the terminal on open,
		-- as a fraction of the screen so it scales with the window size.
		-- Bump the 0.2 for a taller docked terminal, lower it for a shorter one.
		size = function(term)
			if term.direction == 'vertical' then
				return math.floor(vim.o.columns * 0.4)
			end
			return math.floor(vim.o.lines * 0.2)
		end,
		persist_size = true, -- remember a size you resized to during the session
		-- Docked (default horizontal split); not float.
		shade_terminals = false, -- don't darken; keep the terminal transparent
		-- Transparent terminal background so it inherits the (transparent) editor.
		highlights = {
			Normal = { guibg = 'NONE' },
			NormalFloat = { guibg = 'NONE' },
			FloatBorder = { guifg = term_border, guibg = 'NONE' },
		},
		float_opts = {
			border = 'curved', -- thin rounded border (only used by float terminals, e.g. lazygit)
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
