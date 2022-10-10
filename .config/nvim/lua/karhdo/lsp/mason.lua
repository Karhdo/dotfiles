local status, mason = pcall(require, "mason")
local status2, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status or not status2 then
	return
end

local servers = { "sumneko_lua", "tailwindcss", "cssls", "html", "tsserver", "quick_lint_js" }

mason.setup()
mason_lspconfig.setup({
	ensure_installer = servers,
})

--------------------SETUP SERVERS--------------------
for _, server in pairs(mason_lspconfig.get_installed_servers()) do
	local opts = {
		on_attach = require("karhdo.lsp.lspconfig").on_attach,
		capabilities = require("karhdo.lsp.lspconfig").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "karhdo.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	require("lspconfig")[server].setup(opts)
end
