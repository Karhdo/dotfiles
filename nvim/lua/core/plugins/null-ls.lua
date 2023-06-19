---@type LazyPlugin
local M = {
	"jose-elias-alvarez/null-ls.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")
	local lsp = require("core.utils.lsp")

	require("mason-null-ls").setup({
		ensure_installed = {
			"stylua",
			"prettierd",
			"codespell",
		},
	})

	-- TODO: use glob for this
	local function has_stylua(utils)
		return utils.root_has_file("stylua.toml", ".stylua.toml")
	end

	local function has_prettier(utils)
		return utils.root_has_file(".prettierrc", ".prettierrc.json")
	end

	local filetype_config = { html = { disable_format = false } }

	--Customize null-ls attach
	--@param client table
	--@param bufnr  number
	local function on_attach(client, bufnr)
		lsp.setup_common_mappings(client, bufnr)

		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local config = filetype_config[filetype] or {}
		local mapper = require("core.utils.mapper")

		if not config.disable_format then
			if client.server_capabilities.documentFormattingProvider then
				mapper.nnoremap({
					"<Leader>ff",
					vim.lsp.buf.format,
					buffer = bufnr,
					nowait = true,
				})
			end
		end

		if not config.disable_rename and client.server_capabilities.renameProvider then
			mapper.nnoremap({ "<Leader>rr", vim.lsp.buf.rename, buffer = bufnr, nowait = true })
		end
	end

	null_ls.setup({
		on_attach = on_attach,
		sources = {
			null_ls.builtins.formatting.prettierd.with({
				filetypes = { "css", "scss", "sass", "markdown" },
				condition = function(utils)
					return not has_prettier(utils)
				end,
			}),

			null_ls.builtins.formatting.prettierd.with({
				filetypes = {
					"css",
					"scss",
					"sass",
					"markdown",
					"html",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				condition = function(utils)
					return has_prettier(utils)
				end,
			}),

			null_ls.builtins.diagnostics.stylelint.with({
				condition = function(utils)
					return utils.root_has_file(".stylelintrc.json")
				end,
			}),

			null_ls.builtins.formatting.stylua.with({ condition = has_stylua }),
			-- use lua formatter as default
			null_ls.builtins.formatting.lua_format.with({
				condition = function(utils)
					return not has_stylua(utils)
				end,
			}),

			null_ls.builtins.diagnostics.codespell,
		},
	})
end

return M
