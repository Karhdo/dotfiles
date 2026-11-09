-- Indent guides with an animated current scope, smooth scrolling, LSP reference
-- highlights for the word under the cursor, and terminals: a docked one (<C-\>)
-- and floating lazygit (<localleader>gg) / lazydocker (<localleader>gd).

-- Window navigation only in the docked terminal; the floating TUIs need these keys.
local docked_keys = {
	hide = { [[<C-\>]], 'hide', mode = 't', desc = 'Hide terminal' },
}
for _, dir in ipairs({ 'h', 'j', 'k', 'l' }) do
	docked_keys['wincmd_' .. dir] = {
		'<C-' .. dir .. '>',
		'<Cmd>wincmd ' .. dir .. '<CR>',
		mode = 't',
		desc = 'Go to window ' .. dir,
	}
end

local function toggle_terminal()
	Snacks.terminal.toggle(nil, {
		win = { height = 0.2, wo = { winbar = '' }, keys = docked_keys },
	})
end

local function toggle_tui(cmd)
	Snacks.terminal.toggle(cmd, {
		win = {
			border = 'rounded',
			backdrop = false,
			keys = { hide = { '<C-q>', 'hide', mode = 't', desc = 'Hide ' .. cmd } },
		},
	})
end

return {
	'folke/snacks.nvim',
	lazy = false, -- snacks hooks its modules in at startup and lazy-loads each one itself
	priority = 1000,
	keys = {
		{
			']]',
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = 'Next reference',
		},
		{
			'[[',
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = 'Previous reference',
		},
		{ [[<C-\>]], toggle_terminal, mode = { 'n', 'i' }, desc = 'Toggle terminal' },
		{
			'<localleader>gg',
			function()
				toggle_tui('lazygit')
			end,
			desc = 'Toggle lazygit',
		},
		{
			'<localleader>gd',
			function()
				toggle_tui('lazydocker')
			end,
			desc = 'Toggle lazydocker',
		},
	},
	opts = {
		indent = {
			indent = { char = '┊' },
			scope = { char = '┊' },
			-- Plugin windows already have a non-empty buftype; markdown is the only real file left out.
			filter = function(buf)
				return vim.bo[buf].buftype == '' and vim.bo[buf].filetype ~= 'markdown'
			end,
		},
		-- Scope textobjects (ii/ai) and jumps ([i/]i), as mini.indentscope had.
		scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
	},
}
