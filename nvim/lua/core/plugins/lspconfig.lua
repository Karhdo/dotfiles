---@type LazyPlugin
local M = {
	"neovim/nvim-lspconfig",
	lazy = false,
	enabled = not vim.g.vscode,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/typescript.nvim",
		"folke/neodev.nvim",
	},
}

function M.config()
	local lsp = require("core.utils.lsp")
	local icons = require("core.global.style").icons.git

	vim.diagnostic.config({
		severity_sort = true,
		signs = true,
		underline = true,
		update_on_insert = false,
	})

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

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(function(...)
		return vim.lsp.diagnostic.on_publish_diagnostics(...)
	end, { virtual_text = { prefix = "▇", spacing = 2, severity_sort = true } })

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	lsp.setup_servers()
end

return M
