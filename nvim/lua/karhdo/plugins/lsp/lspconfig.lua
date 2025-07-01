local float_opt = { scope = 'cursor', focusable = false }

local M = {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		'hrsh7th/cmp-nvim-lsp',
		{ 'folke/neodev.nvim', opts = {} },
		{ 'antosha417/nvim-lsp-file-operations', config = true },
	},
}

-- Diagnostic navigation
local function diag_go(dir, severity)
	vim.diagnostic[dir]({
		severity = severity,
		float = float_opt,
	})
end

M.diag_go_next = function()
	diag_go('goto_next')
end
M.diag_go_prev = function()
	diag_go('goto_prev')
end
M.diag_go_next_warn = function()
	diag_go('goto_next', { min = vim.diagnostic.severity.WARN })
end
M.diag_go_prev_warn = function()
	diag_go('goto_prev', { min = vim.diagnostic.severity.WARN })
end
M.diag_go_next_err = function()
	diag_go('goto_next', vim.diagnostic.severity.ERROR)
end
M.diag_go_prev_err = function()
	diag_go('goto_prev', vim.diagnostic.severity.ERROR)
end

-- Keymapping helper
local function set_keymap(mode, key, action, opts)
	vim.keymap.set(mode, key, action, opts)
end

-- on_attach function (run when LSP attaches to buffer)
local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, silent = true }

	-- Diagnostic navigation
	set_keymap('n', ']g', M.diag_go_next, opts)
	set_keymap('n', '[g', M.diag_go_prev, opts)
	set_keymap('n', ']w', M.diag_go_next_warn, opts)
	set_keymap('n', '[w', M.diag_go_prev_warn, opts)
	set_keymap('n', ']e', M.diag_go_next_err, opts)
	set_keymap('n', '[e', M.diag_go_prev_err, opts)

	-- LSP actions
	set_keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })
	set_keymap('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename' })
	set_keymap('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
	set_keymap('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration' })
	set_keymap('n', 'gR', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Go to type definition' })
	set_keymap('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover info' })
end

M.config = function()
	local cmp_nvim_lsp = require('cmp_nvim_lsp')
	local mason_lspconfig = require('mason-lspconfig')

	-- Configure LSP capabilities
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Diagnostic UI
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '',
				[vim.diagnostic.severity.WARN] = '',
				[vim.diagnostic.severity.HINT] = '󰠠',
				[vim.diagnostic.severity.INFO] = '',
			},
		},
		virtual_text = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = float_opt,
	})

	-- General LSP config for all servers
	vim.lsp.config('*', {
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- Specific config for Lua
	vim.lsp.config('lua_ls', {
		settings = {
			Lua = {
				diagnostics = {
					globals = { 'vim' },
				},
				completion = {
					callSnippet = 'Replace',
				},
			},
		},
	})
end

return M
