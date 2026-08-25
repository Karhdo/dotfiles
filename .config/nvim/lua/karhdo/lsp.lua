local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- Set keybindings
		opts.desc = 'Show LSP references'
		keymap.set('n', 'gR', '<cmd>Telescope lsp_references<cr>', opts)

		opts.desc = 'Show LSP implementations'
		keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opts)

		opts.desc = 'Go to declaration'
		keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

		opts.desc = 'Go to definition'
		keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

		opts.desc = 'Smart rename'
		keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

		opts.desc = 'Show documentation for what is under cursor'
		keymap.set('n', 'K', vim.lsp.buf.hover, opts)

		opts.desc = 'Show buffer diagnostics'
		keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<cr>', opts)

		opts.desc = 'Show line diagnostics'
		keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

		opts.desc = 'Go to previous diagnostic'
		keymap.set('n', '[d', function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer

		opts.desc = 'Go to next diagnostic'
		keymap.set('n', ']d', function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer

		opts.desc = 'Restart LSP server'
		keymap.set('n', '<leader>lr', ':LspRestart<cr>', opts)

		opts.desc = 'Code Action'
		keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

		-- Inlay hints: inferred types, parameter names, etc.
		--
		-- Deliberately NOT gated on client:supports_method('textDocument/inlayHint'):
		-- jdtls registers that capability *dynamically*, well after LspAttach fires,
		-- so the gate reads false and Java silently never gets hints. The state is
		-- per buffer, not per client, and Neovim only sends requests to clients that
		-- advertise support -- so enabling it unconditionally costs nothing on a
		-- buffer whose servers do not.
		vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

		opts.desc = 'Toggle inlay hints'
		keymap.set('n', '<leader>ih', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
		end, opts)
	end,
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = ' ',
			[severity.WARN] = ' ',
			[severity.HINT] = '󰠠 ',
			[severity.INFO] = ' ',
		},
	},
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { scope = 'cursor', focusable = false },
})
