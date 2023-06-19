-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
-- local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true -- Show line number
opt.relativenumber = true -- Show Relative number
opt.numberwidth = 5 -- Space between
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.wrap = true -- Automatically wrap text that extends beyond the screen length
opt.termguicolors = true -- Reads the hex gui color values of various highlight group
opt.mouse = "a" -- Mouse interaction
opt.cursorline = true -- Highlight current line
opt.clipboard = "unnamedplus"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Shift 4 spaces when tab
opt.tabstop = 2 -- 1 tab == 4 spaced
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Formatting
-----------------------------------------------------------
opt.list = true
opt.listchars:append("eol:↴")
