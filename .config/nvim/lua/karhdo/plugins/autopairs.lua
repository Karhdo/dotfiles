-- Auto-close brackets and quotes.
return {
	'windwp/nvim-autopairs',
	event = 'InsertEnter',
	dependencies = { 'hrsh7th/nvim-cmp' },
	opts = {
		check_ts = true,
		ts_config = {
			lua = { 'string' }, -- No pairs inside Lua strings
			javascript = { 'template_string' }, -- No pairs inside JS template strings
		},
	},
	config = function(_, opts)
		require('nvim-autopairs').setup(opts)

		-- Add the closing pair after confirming a function/method completion.
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
	end,
}
