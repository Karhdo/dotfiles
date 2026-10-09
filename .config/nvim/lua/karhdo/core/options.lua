local opt = vim.opt

vim.g.netrw_liststyle = 3 -- Tree view for netrw (`nvim <dir>`)

-- UI
opt.mouse = 'a'
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5
opt.cursorline = true
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes' -- Always shown, so signs don't shift the text

-- Clipboard
opt.clipboard = 'unnamedplus'

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Wrapping
opt.wrap = true
opt.linebreak = true -- Wrap at word boundaries, not mid-word
opt.breakindent = true -- Keep wrapped lines visually indented

-- Whitespace
opt.list = true
opt.listchars:append('eol:↴')
opt.backspace = 'indent,eol,start'

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Search
opt.ignorecase = true
opt.smartcase = true -- Case-sensitive once the pattern has an uppercase letter

-- Which-key popup delay
opt.timeout = true
opt.timeoutlen = 500
