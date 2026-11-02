-- Server-agnostic LSP setup: buffer-local keymaps on attach and diagnostic
-- display. Per-server config lives in plugins/lsp/.
local styles = require('karhdo.core.styles')
local icons = styles.icons.diagnostics

-- Floats are transparent (tokyonight), so without a border the hover and diagnostic
-- popups blend into the code under them. Thin and rounded, like the toggleterm floats.
local float_border = 'rounded'
local hover_opts = { border = float_border, max_width = 100, max_height = 25 }

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
		map('n', 'K', function()
			vim.lsp.buf.hover(hover_opts)
		end, 'Show documentation under cursor')
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

-- Like Error Lens, show only the most severe diagnostic per line inline (pyright and ruff
-- often report the same problem); `gl` shows them all. Diagnostics arrive per namespace
-- (one per server or linter), so gather every namespace's and draw them in our own.
local virtual_text = vim.diagnostic.handlers.virtual_text
local most_severe_ns = vim.api.nvim_create_namespace('KarhdoMostSevere')
vim.diagnostic.handlers.virtual_text = {
	show = function(_, bufnr, _, opts)
		local by_line = {}
		for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
			local current = by_line[diagnostic.lnum]
			if not current or diagnostic.severity < current.severity then
				by_line[diagnostic.lnum] = diagnostic
			end
		end
		virtual_text.show(most_severe_ns, bufnr, vim.tbl_values(by_line), opts)
	end,
	hide = function(_, bufnr)
		virtual_text.hide(most_severe_ns, bufnr)
	end,
}

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = icons.error,
			[severity.WARN] = icons.warn,
			[severity.INFO] = icons.info,
			[severity.HINT] = icons.hint,
		},
		-- Error Lens look: tint the whole line (colors in tokyonight.lua). Hints are left
		-- out; they mostly mark unused code, which is already dimmed.
		linehl = {
			[severity.ERROR] = 'DiagnosticLineError',
			[severity.WARN] = 'DiagnosticLineWarn',
			[severity.INFO] = 'DiagnosticLineInfo',
		},
	},
	virtual_text = {
		spacing = 4,
		source = 'if_many', -- Name the server only when several report on the buffer
		prefix = function(diagnostic)
			return icons[({ 'error', 'warn', 'info', 'hint' })[diagnostic.severity]]
		end,
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { scope = 'cursor', focusable = false, border = float_border },
})
