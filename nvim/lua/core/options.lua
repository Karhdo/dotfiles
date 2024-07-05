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

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-----------------------------------------------------------
-- Powershell options (Windows)
-----------------------------------------------------------
local powershell_options = {
  shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
  shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
  shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
  shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
  shellquote = "",
  shellxquote = "",
}

for option, value in pairs(powershell_options) do
  vim.opt[option] = value
end
