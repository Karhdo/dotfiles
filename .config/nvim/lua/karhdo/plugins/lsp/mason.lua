-- Installs LSP servers and tools, and enables the installed servers.
return {
	'mason-org/mason-lspconfig.nvim',
	-- Must run before the first buffer's FileType so its servers get enabled.
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		{
			'mason-org/mason.nvim',
			cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate', 'MasonLog' },
			opts = {
				ui = {
					icons = {
						package_pending = '➜',
						package_installed = '',
						package_not_installed = '',
					},
				},
			},
		},
		{
			'WhoIsSethDaniel/mason-tool-installer.nvim',
			opts = {
				-- Keep in sync with conform's `formatters_by_ft` (formatting.lua)
				-- and nvim-lint's `linters_by_ft` (linting.lua).
				ensure_installed = {
					'stylua',
					'prettierd',
					'codespell',
					'black',
					'google-java-format',
					'ktlint',
				},
			},
		},
		'neovim/nvim-lspconfig',
	},
	opts = {
		ensure_installed = {
			'ts_ls',
			'html',
			'cssls',
			'tailwindcss',
			'lua_ls',
			'prismals',
			'pyright',
			'eslint',
			'jdtls',
		},
		-- jdtls is started by nvim-jdtls (jdtls.lua), not mason-lspconfig.
		--
		-- kotlin_lsp is installed by hand under ~/.local/share/nvim/mason/packages/kotlin-lsp/
		-- and configured and enabled from lspconfig.lua; letting Mason manage it would
		-- replace that build with the registry's.
		automatic_enable = {
			exclude = { 'jdtls', 'kotlin_lsp' },
		},
	},
}
