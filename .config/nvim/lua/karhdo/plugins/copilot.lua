-- GitHub Copilot inline suggestions (accepted with <Tab>, see blink-cmp.lua).
return {
	'github/copilot.vim',
	event = 'InsertEnter',
	cmd = 'Copilot',
	-- Its own <Tab> map wraps whichever <Tab> map it finds first, which depends on
	-- load order; blink-cmp.lua accepts suggestions instead.
	init = function()
		vim.g.copilot_no_tab_map = true
	end,
}
