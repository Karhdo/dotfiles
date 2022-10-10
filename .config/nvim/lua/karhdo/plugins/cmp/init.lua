return function()
	local cmp_status_ok, cmp = pcall(require, "cmp")
	local snip_status_ok, luasnip = pcall(require, "luasnip")
	local lspkind_status_ok, lspkind = pcall(require, "lspkind")

	if not cmp_status_ok or not snip_status_ok or not lspkind_status_ok then
		return
	end

	local source_mapping = {
		nvim_lsp = "[LSP]",
		jira = "[Jira]",
		emoji = "[Emoji]",
		path = "[Path]",
		calc = "[Calc]",
		spell = "[Spell]",
		orgmode = "[Org]",
		buffer = "[Buffer]",
		luasnip = "[LuaSnip]",
		cmp_tabnine = "[Tab9]",
		npm = "[NPM]",
		crates = "[Crates]",
	}

	require("luasnip/loaders/from_vscode").lazy_load()

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<Tab>"] = cmp.mapping.confirm({ maxwidth = 50, select = true }),
		},
		formatting = {
			format = lspkind.cmp_format({ maxwidth = 50, with_text = true, menu = source_mapping }),
		},
		sources = {
			{ name = "nvim_lsp", max_item_count = 4 },
			{ name = "luasnip", max_item_count = 4 },
			{ name = "cmp_tabnine", max_item_count = 2 },
			{ name = "buffer" },
			{ name = "path" },
		},
		window = {
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			},
		},
	})
end
