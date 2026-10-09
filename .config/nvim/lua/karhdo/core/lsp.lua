-- Server-agnostic LSP setup: buffer-local keymaps on attach and diagnostic
-- display. Per-server config lives in plugins/lsp/.
local icons = require('karhdo.core.styles').icons.diagnostics

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('KarhdoLspAttach', { clear = true }),
	callback = function(ev)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
		end

		map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
		map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
		map('n', 'gi', '<Cmd>FzfLua lsp_implementations<CR>', 'Show LSP implementations')
		map('n', 'gR', '<Cmd>FzfLua lsp_references<CR>', 'Show LSP references')
		map('n', 'K', vim.lsp.buf.hover, 'Show documentation under cursor')
		map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
		map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code action')
		map('n', '<leader>lr', '<Cmd>LspRestart<CR>', 'Restart LSP server')

		map('n', '<leader>d', vim.diagnostic.open_float, 'Show line diagnostics')
		map('n', '<leader>D', '<Cmd>FzfLua diagnostics_document<CR>', 'Show buffer diagnostics')
		map('n', '[d', function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, 'Previous diagnostic')
		map('n', ']d', function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, 'Next diagnostic')

		-- Inlay hints are off by default (they shift text and get noisy). The map is
		-- deliberately NOT gated on client:supports_method('textDocument/inlayHint'):
		-- jdtls registers that capability dynamically, well after LspAttach, so the
		-- gate would read false for Java. Requests only go to servers that support
		-- it, so the toggle is simply inert elsewhere.
		map('n', '<leader>ih', function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
		end, 'Toggle inlay hints')
	end,
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = icons.error,
			[severity.WARN] = icons.warn,
			[severity.INFO] = icons.info,
			[severity.HINT] = icons.hint,
		},
	},
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { scope = 'cursor', focusable = false },
})
