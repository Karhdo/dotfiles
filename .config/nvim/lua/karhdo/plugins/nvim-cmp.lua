-- Completion menu with LSP, snippet, buffer and path sources.
return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		{
			'L3MON4D3/LuaSnip',
			version = 'v2.*',
			build = 'make install_jsregexp', -- Optional; enables snippet transformations
		},
		'saadparwaiz1/cmp_luasnip',
		'rafamadriz/friendly-snippets',
		'onsails/lspkind.nvim',
	},
	config = function()
		local cmp = require('cmp')
		local luasnip = require('luasnip')
		local lspkind = require('lspkind')

		-- Tag shown next to each item; mirrors `sources` below.
		local menu = {
			nvim_lsp = '[LSP]',
			luasnip = '[LuaSnip]',
			buffer = '[Buffer]',
			path = '[Path]',
		}

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
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.abort(),
			},
			formatting = {
				format = lspkind.cmp_format({
					menu = menu,
					mode = 'symbol_text',
					ellipsis = '...',
				}),
				expandable_indicator = true,
			},
			sources = {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'buffer' },
				{ name = 'path' },
			},
			window = {
				documentation = { border = require('karhdo.core.styles').border },
			},
		})
	end,
}
