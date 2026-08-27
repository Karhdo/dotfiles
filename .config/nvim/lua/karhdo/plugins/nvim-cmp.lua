local M = {
	'hrsh7th/nvim-cmp',
	event = { 'InsertEnter' },
	dependencies = {
		'hrsh7th/cmp-buffer', -- source for text in buffer
		'hrsh7th/cmp-path', -- source for file system paths
		{
			'L3MON4D3/LuaSnip',
			-- follow latest release.
			version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = 'make install_jsregexp',
		},
		'saadparwaiz1/cmp_luasnip', -- for autocompletion
		'rafamadriz/friendly-snippets', -- useful snippets
		'onsails/lspkind.nvim', -- vs-code like pictograms
	},
}

function M.config()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local lspkind = require('lspkind')

	local border = require('karhdo.core.styles').border

	-- Mirrors the `sources` list below; a source with no entry here shows no tag.
	local menu = {
		nvim_lsp = '[LSP]',
		luasnip = '[LuaSnip]',
		buffer = '[Buffer]',
		path = '[Path]',
	}

	-- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
	require('luasnip.loaders.from_vscode').lazy_load()

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
			-- Tab priority: confirm the completion menu -> jump to the next snippet
			-- placeholder -> fall through (copilot.vim's accept map lives on Tab).
			--
			-- The check MUST be cmp.confirm()'s return value, not cmp.visible().
			-- With select = false the menu is usually open with nothing selected,
			-- and cmp.confirm() then does nothing and returns false; branching on
			-- cmp.visible() swallows Tab in exactly that state and Copilot never
			-- sees the key. Mode 's' is needed too, since LuaSnip puts you in
			-- select mode on each placeholder.
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.confirm({ select = false }) then
					return
				end
				if luasnip.locally_jumpable(1) then
					return luasnip.jump(1)
				end
				fallback()
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(), -- show completion suggestions
			['<C-e>'] = cmp.mapping.abort(), -- close completion window
		},
		formatting = {
			format = function(entry, item)
				item = lspkind.cmp_format({
					menu = menu,
					mode = 'symbol_text',
					ellipsis = '...',
				})(entry, item)

				return item
			end,
			expandable_indicator = true,
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' }, -- snippets
			{ name = 'buffer' }, -- text within current buffer
			{ name = 'path' }, -- file system paths
		},
		window = {
			documentation = {
				border = border,
			},
		},
	})
end

return M
