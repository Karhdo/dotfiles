---@type LazyPlugin[]
      local kinds = require("core.global.style").lsp.kinds

local M = {
	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({
				mode = "symbol_text",
				preset = "codicons",
				symbol_map = kinds,
			})
		end,
	},
  {
		"simrat39/symbols-outline.nvim",
		keys = { "<Leader>to" },
		cmd = { "SymbolsOutline" },
		config = function()
			require("symbols-outline").setup()

			local mapper = require("core.utils.mapper")

			mapper.nnoremap({ "<Leader>to", "<Cmd>SymbolsOutline<CR>" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		enabled = not vim.g.vscode,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"folke/neodev.nvim",
		},
		config = function()
      local lsp = require("core.utils.lsp")
			local commander = require("core.utils.commander")
			local icons = require("core.global.style").icons.git

			commander.command("LspLog", function()
				vim.cmd.edit(vim.lsp.get_log_path())
			end, {})

			vim.diagnostic.config({
				severity_sort = true,
				signs = true,
				underline = true,
				update_on_insert = false,
			})

			-- =============================================================================
			-- Signs
			-- =============================================================================

			vim.fn.sign_define({
				{
					name = "DiagnosticSignError",
					text = icons.error,
					texthl = "DiagnosticSignError",
				},
				{
					name = "DiagnosticSignHint",
					text = icons.hint,
					texthl = "DiagnosticSignHint",
				},
				{
					name = "DiagnosticSignWarn",
					text = icons.warn,
					texthl = "DiagnosticSignWarn",
				},
				{
					name = "DiagnosticSignInfo",
					text = icons.info,
					texthl = "DiagnosticSignInfo",
				},
			})

			-- =============================================================================
			-- Handler Override
			-- =============================================================================

			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(function(...)
				return vim.lsp.diagnostic.on_publish_diagnostics(...)
			end, {
				virtual_text = {
					prefix = "▇",
					spacing = 2,
					severity_sort = true,
				},
			})

			-- NOTE: the hover handler returns the bufnr,winnr so can be used for mappings
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			lsp.setup_servers()
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = false,
		enabled = not vim.g.vscode,
		dependencies = {
			"williamboman/mason.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			local lsp = require("core.utils.lsp")

			require("mason-null-ls").setup({
        automatic_installation = true,
				ensure_installed = {
					"stylua",
					"hadolint",
					"prettierd",
					"stylelint",
					"shellcheck",
					"codespell",
				},
			})

			local filetype_config = { html = { disable_format = false } }

			---Customize null-ls attach
			---@param client table
			---@param bufnr  number
			local function on_attach(client, bufnr)
				lsp.setup_autocommands(client, bufnr)
				lsp.setup_common_mappings(client, bufnr)

				local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
				local config = filetype_config[filetype] or {}
				local mapper = require("core.utils.mapper")

				if not config.disable_format then
					if client.server_capabilities.documentFormattingProvider then
						mapper.nnoremap({
							"<Leader><Leader>f",
							vim.lsp.buf.format,
							buffer = bufnr,
							nowait = true,
						})
					end

					if client.server_capabilities.documentRangeFormattingProvider then
						mapper.vnoremap({
							"<Leader><Leader>f",
							vim.lsp.buf.format,
							buffer = bufnr,
							nowait = true,
						})
					end
				end

				if not config.disable_rename and client.server_capabilities.renameProvider then
					mapper.nnoremap({
						"<Leader>rr",
						vim.lsp.buf.rename,
						buffer = bufnr,
						nowait = true,
					})
				end
			end

			null_ls.setup({
				on_attach = on_attach,
				sources = {
					-- Formatting
					-- null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.prettierd,

					-- CSS
					null_ls.builtins.diagnostics.stylelint,

					-- Lua
					null_ls.builtins.formatting.stylua.with({
						filetypes = { "lua" },
          }),

					-- SQL
					null_ls.builtins.formatting.sqlformat,

					-- Shell script
					--null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.formatting.shfmt.with({
						filetypes = { "sh", "zsh" },
					}),

					-- Docker
					null_ls.builtins.diagnostics.hadolint,

					-- NGINX
					null_ls.builtins.formatting.nginx_beautifier,

					-- Spell(English linter)
					null_ls.builtins.diagnostics.codespell,
				},
			})
		end,
	},
}

return M
