local M = {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufRead', 'BufNewFile' },
	build = ':TSUpdate', -- We recommend updating the parsers on update
	dependencies = {
		'windwp/nvim-ts-autotag',
	},
}

function M.config()
	local langs = {
		'lua',
		'typescript',
		'javascript',
		'java',
		'kotlin',
		'yaml',
		'properties',
		'xml',
		'dockerfile',
		'sql',
		'markdown',
		'markdown_inline',
	}

	local treesitter = require('nvim-treesitter.configs')

	-- Configure treesitter
	treesitter.setup({
		modules = {},
		ignore_install = {},
		sync_install = false,
		auto_install = false,
		ensure_installed = langs,
		indent = { enable = true },
		autotag = { enable = true },
		highlight = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<C-space>',
				node_incremental = '<C-space>',
				scope_incremental = false,
				node_decremental = '<bs>',
			},
		},
	})

	-- nvim 0.12 compat: nvim-treesitter's set-lang-from-info-string! directive
	-- crashes on stale nodes during the conceal_line decoration pass. Wrap the
	-- inner call in pcall so rendering never aborts.
	vim.treesitter.query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
		local node = match[pred[2]]
		if not node then
			return
		end
		local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
		if not ok or not text then
			return
		end
		metadata['injection.language'] = text:lower()
	end, { force = true, all = true })
end

return M
