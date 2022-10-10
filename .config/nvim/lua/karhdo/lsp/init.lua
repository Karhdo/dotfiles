local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("karhdo.lsp.lspconfig").setup()
require("karhdo.lsp.mason")
-- require("karhdo.lsp.lsp-installer")
require("karhdo.lsp.null-ls")

-- Custom key map
local map = karhdo.map
local float_opt = { scope = "cursor", focusable = false }

map("n", "]g", function()
	vim.diagnostic.goto_next({ float = float_opt })
end)

map("n", "[g", function()
	vim.diagnostic.goto_prev({ float = float_opt })
end)

map("n", "]w", function()
	vim.diagnostic.goto_next({
		severity = { min = vim.diagnostic.severity.WARN },
		float = float_opt,
	})
end)

map("n", "[w", function()
	vim.diagnostic.goto_prev({
		severity = { min = vim.diagnostic.severity.WARN },
		float = float_opt,
	})
end)

map("n", "]e", function()
	vim.diagnostic.goto_next({
		severity = vim.diagnostic.severity.ERROR,
		float = float_opt,
	})
end)

map("n", "[e", function()
	vim.diagnostic.goto_prev({
		severity = vim.diagnostic.severity.ERROR,
		float = float_opt,
	})
end)
