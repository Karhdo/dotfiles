local M = {
	'nvim-treesitter/nvim-treesitter',
	-- `master` is frozen and declares nvim 0.12 unsupported; `main` is the
	-- rewrite that targets 0.12+. It has no module system -- highlight, indent
	-- and incremental selection are wired up by hand in `config` below.
	branch = 'main',
	-- Upstream states `main` does not support lazy-loading: it registers its
	-- filetype -> parser mappings from `plugin/` at startup.
	lazy = false,
	build = ':TSUpdate',
	dependencies = {
		'windwp/nvim-ts-autotag',
	},
}

-- Parsers to keep installed. `main` builds these from grammar with
-- tree-sitter-cli, so a new entry costs a one-off compile on the next startup.
local ensure_installed = {
	'dockerfile',
	'go',
	'java',
	'javascript',
	'kotlin',
	'lua',
	'markdown',
	'markdown_inline',
	'prisma',
	'properties',
	'python',
	'sql',
	'tsx',
	'typescript',
	'xml',
	'yaml',
}

---Enable treesitter highlighting, and indentation where a query exists for it.
---@param buf integer
local function attach(buf)
	local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
	if not lang or not pcall(vim.treesitter.start, buf, lang) then
		return
	end

	-- Not every language ships an `indents.scm` (kotlin, for one). Pointing
	-- indentexpr at treesitter for those makes it return 0 for every line, which
	-- drops each new line into column 0 -- leave them on their runtime indent
	-- file instead.
	if vim.treesitter.query.get(lang, 'indents') then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

---`main` dropped the incremental_selection module; these three functions are
---the same behaviour on top of the plain treesitter API.
---@type table<integer, TSNode[]>
local selection = {}

---@param buf integer
---@param node TSNode
local function select_node(buf, node)
	local srow, scol, erow, ecol = node:range()

	-- A node's end is exclusive, so one ending at column 0 really ends at the
	-- end of the previous line.
	if ecol == 0 then
		erow = erow - 1
		ecol = #(vim.api.nvim_buf_get_lines(buf, erow, erow + 1, false)[1] or '')
	end

	if vim.fn.mode():match('[vV\22]') then
		vim.cmd('normal! \27')
	end

	vim.fn.setpos('.', { buf, srow + 1, scol + 1, 0 })
	vim.cmd('normal! v')
	vim.fn.setpos('.', { buf, erow + 1, math.max(ecol, 1), 0 })
end

local function init_selection()
	local buf = vim.api.nvim_get_current_buf()
	local node = vim.treesitter.get_node({ bufnr = buf })
	if not node then
		return
	end

	selection[buf] = { node }
	select_node(buf, node)
end

local function node_incremental()
	local buf = vim.api.nvim_get_current_buf()
	local stack = selection[buf]
	if not stack or #stack == 0 then
		return init_selection()
	end

	local node = stack[#stack]
	local srow, scol, erow, ecol = node:range()

	-- Skip ancestors that span exactly the same range, otherwise a keypress
	-- would appear to do nothing.
	local parent = node:parent()
	while parent do
		local psrow, pscol, perow, pecol = parent:range()
		if psrow ~= srow or pscol ~= scol or perow ~= erow or pecol ~= ecol then
			break
		end
		parent = parent:parent()
	end

	if not parent then
		return
	end

	stack[#stack + 1] = parent
	select_node(buf, parent)
end

local function node_decremental()
	local buf = vim.api.nvim_get_current_buf()
	local stack = selection[buf]
	if not stack or #stack < 2 then
		return
	end

	stack[#stack] = nil
	select_node(buf, stack[#stack])
end

function M.config()
	local treesitter = require('nvim-treesitter')

	treesitter.setup({})

	local installed = treesitter.get_installed('parsers')
	local missing = vim.tbl_filter(function(lang)
		return not vim.tbl_contains(installed, lang)
	end, ensure_installed)

	if #missing > 0 then
		treesitter.install(missing)
	end

	-- Autotag used to be a nvim-treesitter module; on `main` it sets itself up.
	require('nvim-ts-autotag').setup({})

	local group = vim.api.nvim_create_augroup('KarhdoTreesitter', { clear = true })

	vim.api.nvim_create_autocmd('FileType', {
		group = group,
		callback = function(args)
			attach(args.buf)
		end,
	})

	vim.api.nvim_create_autocmd('BufDelete', {
		group = group,
		callback = function(args)
			selection[args.buf] = nil
		end,
	})

	vim.keymap.set('n', '<C-space>', init_selection, { desc = 'Treesitter: select node' })
	vim.keymap.set('x', '<C-space>', node_incremental, { desc = 'Treesitter: expand selection' })
	vim.keymap.set('x', '<bs>', node_decremental, { desc = 'Treesitter: shrink selection' })

	-- `config` runs before the first file's FileType fires, but not when this is
	-- re-sourced from a running session.
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			attach(buf)
		end
	end
end

return M
