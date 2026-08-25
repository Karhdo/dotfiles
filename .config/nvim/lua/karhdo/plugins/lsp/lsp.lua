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

			-- ts_ls advertises textDocument/inlayHint but ships every hint category
			-- switched OFF, so enabling hints on the client alone yields nothing.
			-- These preferences are what actually make it emit them.
			local ts_inlay_hints = {
				includeInlayParameterNameHints = 'all',
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = false,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			}

			vim.lsp.config('ts_ls', {
				settings = {
					typescript = { inlayHints = ts_inlay_hints },
					javascript = { inlayHints = ts_inlay_hints },
				},
			})

			-- JetBrains Kotlin LSP (kotlin_lsp) runs from Mason's intellij-server binary, but
			-- it is NOT managed by Mason (kept out of ensure_installed + in automatic_enable.exclude
			-- in mason.lua). Reason: the public builds are EAP/time-bombed and the Mason registry
			-- pins an already-expired version, which Mason would re-download on startup and use,
			-- crashing with exit code 7. A non-expired build lives in
			-- ~/.local/share/nvim/mason/packages/kotlin-lsp/ (currently v262.8190.0,
			-- released 2026-06-17). The frozen faketime date below must sit AFTER the
			-- build's release date and before its expiry.
			--
			-- To stop it expiring, we launch it under `faketime` with a frozen date that
			-- sits inside the build's valid window, so the time-bomb never fires. On macOS
			-- this only works because bin/intellij-server was re-signed (ad-hoc) to add the
			-- `allow-dyld-environment-variables` + `disable-library-validation` entitlements;
			-- without them, hardened runtime strips DYLD_INSERT_LIBRARIES / library validation
			-- blocks libfaketime and faketime is silently a no-op. The JVM runs in-process in
			-- the launcher (not a separate `java`), so the launcher itself is the inject target.
			-- Verified: the intellij-server process maps both libjvm and libfaketime.
			-- If Mason ever re-downloads this package, the binary must be re-signed again.
			-- Absolute faketime path so it resolves even when nvim's PATH lacks /opt/homebrew/bin.
			vim.lsp.config('kotlin_lsp', {
				cmd = {
					'/opt/homebrew/bin/faketime',
					'2026-06-25 12:00:00',
					vim.fn.stdpath('data') .. '/mason/bin/intellij-server',
					'--stdio',
				},
			})
			vim.lsp.enable('kotlin_lsp')
		end,
	},
	{ 'antosha417/nvim-lsp-file-operations', config = true },
	{ 'folke/lazydev.nvim', opts = {} },
}
