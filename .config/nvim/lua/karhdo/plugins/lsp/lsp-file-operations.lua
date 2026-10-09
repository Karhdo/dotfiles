-- Tell LSP servers about renames/moves done in nvim-tree so they fix imports.
return {
	'antosha417/nvim-lsp-file-operations',
	lazy = true, -- Loaded by nvim-lspconfig, which needs its capabilities
	opts = {},
}
