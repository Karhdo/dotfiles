-- Completion menu with LSP, snippet, buffer and path sources.

local function accept_copilot()
	if vim.g.loaded_copilot and vim.fn['copilot#GetDisplayedSuggestion']().text ~= '' then
		return vim.fn['copilot#Accept']('')
	end
end

return {
	'saghen/blink.cmp',
	version = '1.*', -- Release tags ship the prebuilt Rust fuzzy matcher
	event = 'InsertEnter',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			build = 'make install_jsregexp', -- Optional; enables snippet transformations
			dependencies = { 'rafamadriz/friendly-snippets' },
			config = function()
				require('luasnip.loaders.from_vscode').lazy_load()
			end,
		},
		'nvim-mini/mini.icons',
	},
	opts = {
		keymap = {
			preset = 'none',
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' },
			-- Tab: accept the selected item -> jump to the next snippet placeholder ->
			-- accept the Copilot suggestion -> insert a tab. Nothing is preselected, so
			-- an open menu doesn't swallow Tab from Copilot.
			['<Tab>'] = { 'accept', 'snippet_forward', accept_copilot, 'fallback' },
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-Space>'] = { 'show', 'fallback' },
			['<C-e>'] = { 'cancel', 'fallback' },
		},
		snippets = { preset = 'luasnip' },
		sources = {
			default = { 'lsp', 'snippets', 'buffer', 'path' },
		},
		cmdline = { enabled = false },
		completion = {
			list = { selection = { preselect = false, auto_insert = true } },
			documentation = {
				auto_show = true,
				window = { border = require('karhdo.core.styles').border },
			},
			menu = {
				draw = {
					columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' }, { 'source_name' } },
					-- Same glyphs as the navic winbar.
					components = {
						kind_icon = {
							text = function(ctx)
								return require('mini.icons').get('lsp', ctx.kind) .. ' '
							end,
							highlight = function(ctx)
								return select(2, require('mini.icons').get('lsp', ctx.kind))
							end,
						},
					},
				},
			},
		},
	},
}
