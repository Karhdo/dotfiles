local M = {
	"hrsh7th/nvim-cmp",
	enabled = not vim.g.vscode,
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"f3fora/cmp-spell",
		"onsails/lspkind-nvim",
		"tzachar/cmp-tabnine",
	},
}

function M.config()
	local border = require("core.global.style").border
	local cmp = require("cmp")

	local menu = {
		nvim_lsp = "[LSP]",
		jira = "[Jira]",
		emoji = "[Emoji]",
		path = "[Path]",
		calc = "[Calc]",
		spell = "[Spell]",
		buffer = "[Buffer]",
		fuzzy_buffer = "[Fuzzy]",
		luasnip = "[LuaSnip]",
		cmp_tabnine = "[Tab9]",
		npm = "[NPM]",
		crates = "[Crates]",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<Tab>"] = cmp.mapping.confirm({ maxwidth = 50, select = true }),
		},
		formatting = {
			deprecated = true,
			format = require("lspkind").cmp_format({ with_text = true, menu = menu }),
		},
		sources = {
			{ name = "luasnip", max_item_count = 4, priority = 8 },
			{ name = "cmp_tabnine", max_item_count = 3, priority = 7 },
			{ name = "nvim_lsp", priority = 8 },
			{ name = "nvim_lsp_signature_help", priority = 8 },
			{ name = "spell", keywork_length = 3, priority = 5 },
			{ name = "path", priority = 4 },
			{ name = "fuzzy_buffer", max_item_count = 3, priority = 4 },
			{ name = "calc", priority = 3 },
		},
		window = { documentation = { border = border } },
	})
end

return M
