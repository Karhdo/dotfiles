-- Auto-close brackets and quotes. Brackets after an accepted function completion
-- come from blink.cmp itself.
return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	opts = {
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- No pairs inside Lua strings
			javascript = { 'template_string' }, -- No pairs inside JS template strings
		},
	},
}
