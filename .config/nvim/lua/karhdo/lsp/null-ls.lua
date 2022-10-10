local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.prettier.with({ extra_args = { "--single-quote", "--tab-width 4", "--print-width 200" } }),
	formatting.black.with({ extra_args = { "--fast" } }),
	formatting.stylua,
}

null_ls.setup({
	debug = false,
	sources = sources,
	on_attach = function(client)
		-- Format on save
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
		end
	end,
})
