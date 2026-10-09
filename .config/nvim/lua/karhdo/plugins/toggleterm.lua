-- Docked terminal (<C-\>) and a floating lazygit (<localleader>gg).
local lazygit

-- Created on first use, so toggleterm only loads when a terminal is wanted.
local function toggle_lazygit()
	lazygit = lazygit
		or require('toggleterm.terminal').Terminal:new({
			count = 8,
			cmd = 'lazygit',
			direction = 'float',
			hidden = true,
			start_in_insert = true,
			on_open = function(term)
				local function map(lhs, rhs, desc)
					vim.keymap.set('t', lhs, rhs, { buffer = term.bufnr, desc = desc })
				end

				map('<C-q>', function()
					term:close()
				end, 'Close lazygit')
				-- Hand window-navigation keys to lazygit instead of moving windows.
				for _, key in ipairs({ '<C-h>', '<C-j>', '<C-k>', '<C-l>' }) do
					map(key, key, 'Pass ' .. key .. ' to lazygit')
				end
			end,
		})
	lazygit:toggle()
end

return {
	'akinsho/toggleterm.nvim',
	cmd = { 'ToggleTerm', 'TermExec' },
	keys = {
		{ [[<C-\>]], mode = { 'n', 'i' }, desc = 'Toggle terminal' },
		{ '<localleader>gg', toggle_lazygit, desc = 'Toggle lazygit' },
	},
	opts = function()
		-- Tokyo Night's blue for the float border.
		local ok, tokyonight = pcall(require, 'tokyonight.colors')
		local border = ok and tokyonight.setup().blue or '#7aa2f7'

		return {
			open_mapping = [[<C-\>]],
			close_on_exit = true,
			shell = vim.o.shell,
			-- Fraction of the screen so it scales with the window; bump 0.2 for a
			-- taller docked terminal.
			size = function(term)
				if term.direction == 'vertical' then
					return math.floor(vim.o.columns * 0.4)
				end
				return math.floor(vim.o.lines * 0.2)
			end,
			persist_size = true,
			shade_terminals = false, -- Keep the terminal transparent like the editor
			highlights = {
				Normal = { guibg = 'NONE' },
				NormalFloat = { guibg = 'NONE' },
				FloatBorder = { guifg = border, guibg = 'NONE' },
			},
			float_opts = { border = 'curved' },
		}
	end,
	config = function(_, opts)
		require('toggleterm').setup(opts)

		-- Window navigation from toggleterm's own terminals only: fzf-lua also runs
		-- in a terminal buffer and needs <C-j>/<C-k> to move through results.
		vim.api.nvim_create_autocmd('TermOpen', {
			group = vim.api.nvim_create_augroup('KarhdoToggletermKeymaps', { clear = true }),
			pattern = 'term://*toggleterm#*',
			callback = function(ev)
				for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
					vim.keymap.set('t', '<C-' .. dir .. '>', '<Cmd>wincmd ' .. dir .. '<CR>', {
						buffer = ev.buf,
						desc = 'Go to window ' .. dir,
					})
				end
			end,
		})
	end,
}
