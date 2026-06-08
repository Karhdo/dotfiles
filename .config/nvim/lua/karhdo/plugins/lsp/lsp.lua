return {
	{
		'hrsh7th/cmp-nvim-lsp',
		event = { 'BufReadPre', 'BufNewFile' },
		config = function()
			-- import cmp-nvim-lsp plugin
			local cmp_nvim_lsp = require('cmp_nvim_lsp')

			-- used to enable autocompletion (assign to every lsp server config)
			local capabilities = cmp_nvim_lsp.default_capabilities()

			vim.lsp.config('*', {
				capabilities = capabilities,
			})

			-- Mason installs the JetBrains Kotlin LSP as `intellij-server`, but
			-- nvim-lspconfig's default kotlin_lsp config looks for a `kotlin-lsp`
			-- executable (which doesn't exist), so the server never starts. Point
			-- the command at Mason's binary and run it in stdio mode.
			vim.lsp.config('kotlin_lsp', {
				cmd = { vim.fn.stdpath('data') .. '/mason/bin/intellij-server', '--stdio' },
			})
		end,
	},
	{ 'antosha417/nvim-lsp-file-operations', config = true },
	{ 'folke/lazydev.nvim', opts = {} },
}
