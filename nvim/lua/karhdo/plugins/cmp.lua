---@diagnostic disable: missing-fields
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

	local menu = {
		nvim_lsp = '[LSP]',
		jira = '[Jira]',
		emoji = '[Emoji]',
		path = '[Path]',
		calc = '[Calc]',
		spell = '[Spell]',
		buffer = '[Buffer]',
		fuzzy_buffer = '[Fuzzy]',
		luasnip = '[LuaSnip]',
		npm = '[NPM]',
		crates = '[Crates]',
	}

	-- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
	require('luasnip.loaders.from_vscode').lazy_load()

	local lspkind = require('lspkind')
	local tailwind_formatter = require('tailwindcss-colorizer-cmp').formatter

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			['<C-e>'] = cmp.mapping.close(),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-p>'] = cmp.mapping.select_prev_item(),
			['<C-n>'] = cmp.mapping.select_next_item(),
			['<Tab>'] = cmp.mapping.confirm({ select = false }),
		},
		formatting = {
			format = function(entry, item)
				item = lspkind.cmp_format({
					menu = menu,
					with_text = true,
					ellipsis = '...',
				})(entry, item)

				item = tailwind_formatter(entry, item)

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
