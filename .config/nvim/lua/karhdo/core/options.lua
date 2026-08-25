-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
vim.cmd('let g:netrw_liststyle = 3') -- Tree view for netrw

local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.mouse = 'a' -- Mouse interaction
opt.numberwidth = 5 -- Space between
opt.number = true -- Show line number
opt.cursorline = true -- Highlight current line
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.relativenumber = true -- Show Relative number

-----------------------------------------------------------
-- Clipboard
-----------------------------------------------------------
opt.clipboard = 'unnamedplus'

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.tabstop = 2 -- 1 tab == 4 spaced
opt.shiftwidth = 2 -- Shift 4 spaces when tab
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Autoindent new lines
opt.autoindent = true -- Copy indent from current line when starting new one

opt.wrap = true -- Wrap long lines onto the next screen row
opt.linebreak = true -- Wrap at word boundaries, not mid-word
opt.breakindent = true -- Keep wrapped lines visually indented

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------
opt.list = true
opt.listchars:append('eol:↴')
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-----------------------------------------------------------
-- Split windows
-----------------------------------------------------------
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-----------------------------------------------------------
-- Search settings
-----------------------------------------------------------
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift
