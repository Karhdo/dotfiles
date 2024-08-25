-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
vim.cmd("let g:netrw_liststyle = 3") -- Tree view for netrw

local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.mouse = "a" -- Mouse interaction
opt.numberwidth = 5 -- Space between
opt.wrap = true -- Automatically wrap text that extends beyond the screen length
opt.number = true -- Show line number
opt.cursorline = true -- Highlight current line
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.termguicolors = true -- Reads the hex gui color values of various highlight group
opt.relativenumber = true -- Show Relative number

-----------------------------------------------------------
-- Clipboard
-----------------------------------------------------------
opt.clipboard = "unnamedplus"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.tabstop = 2 -- 1 tab == 4 spaced
opt.shiftwidth = 2 -- Shift 4 spaces when tab
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Autoindent new lines
opt.autoindent = true -- Copy indent from current line when starting new one

opt.wrap = false

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------
opt.list = true
opt.listchars:append("eol:↴")
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

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

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-----------------------------------------------------------
-- Powershell options (Windows)
-----------------------------------------------------------
-- local powershell_options = {
--   shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
--   shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
--   shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
--   shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
--   shellquote = "",
--   shellxquote = "",
-- }
--
-- for option, value in pairs(powershell_options) do
--   vim.opt[option] = value
-- end
