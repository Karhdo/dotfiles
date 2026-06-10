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

			-- JetBrains Kotlin LSP (kotlin_lsp) runs from Mason's intellij-server binary, but
			-- it is NOT managed by Mason (kept out of ensure_installed + in automatic_enable.exclude
			-- in mason.lua). Reason: the public builds are EAP/time-bombed and the Mason registry
			-- pins an already-expired version, which Mason would re-download on startup and use,
			-- crashing with exit code 7. The non-expired build (v262.7569.0) was placed into
			-- ~/.local/share/nvim/mason/packages/kotlin-lsp/ by hand, so we point at it and enable
			-- it ourselves. NOTE: this EAP build will itself expire (~1-2 months); if it ever
			-- crashes with exit code 7 again, that's why.
			vim.lsp.config('kotlin_lsp', {
				cmd = { vim.fn.stdpath('data') .. '/mason/bin/intellij-server', '--stdio' },
			})
			vim.lsp.enable('kotlin_lsp')
		end,
	},
	{ 'antosha417/nvim-lsp-file-operations', config = true },
	{ 'folke/lazydev.nvim', opts = {} },
}
