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

-- General diagnostic navigation function
local function diag_go(dir, severity)
	vim.diagnostic[dir]({
		severity = severity,
		float = float_opt,
	})
end

-- Specific diagnostic navigation functions
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

-- Keymapping helper function
local function set_keymap(mode, key, action, opts)
	vim.keymap.set(mode, key, action, opts)
end

M.config = function()
	local lspconfig = require('lspconfig')
	local cmp_nvim_lsp = require('cmp_nvim_lsp')
	local mason_lspconfig = require('mason-lspconfig')

	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('UserLspConfig', {}),
		callback = function(ev)
			local opts = { buffer = ev.buf, silent = true }

			-- Diagnostic navigation
			set_keymap('n', ']g', M.diag_go_next, opts)
			set_keymap('n', '[g', M.diag_go_prev, opts)
			set_keymap('n', ']w', M.diag_go_next_warn, opts)
			set_keymap('n', '[w', M.diag_go_prev_warn, opts)
			set_keymap('n', ']e', M.diag_go_next_err, opts)
			set_keymap('n', '[e', M.diag_go_prev_err, opts)

			-- LSP actions
			set_keymap(
				{ 'n', 'v' },
				'<leader>ca',
				vim.lsp.buf.code_action,
				vim.tbl_extend('force', opts, { desc = 'See available code actions' })
			)
			set_keymap('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Smart rename' }))
			set_keymap('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Go to definition' }))
			set_keymap('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Go to declaration' }))
			set_keymap(
				'n',
				'gR',
				vim.lsp.buf.type_definition,
				vim.tbl_extend('force', opts, { desc = 'Go to type reference' })
			)
			set_keymap('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = 'Show hover information' }))
		end,
	})

	-- Change the Diagnostic symbols in the sign column (gutter)
	local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
	for type, icon in pairs(signs) do
		local hl = 'DiagnosticSign' .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	end

	-- LSP capabilities with autocompletion
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- Setup LSP servers
	mason_lspconfig.setup_handlers({
		function(server_name)
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,
	})
end

return M
