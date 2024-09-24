-- =============================================================================
-- Leader Maps
-- =============================================================================

vim.g.mapleader = ","
vim.g.maplocalleader = " "

-- =============================================================================
--  Keymaps
--  =============================================================================
local keymap = vim.keymap -- for conciseness

------ Clear search highlights ------
keymap.set('n', '<leader>nh', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

------ Windows ------
-- Windows navigator
keymap.set('n', '<c-h>', '<Cmd>wincmd h<CR>', { desc = 'Move to left window' })
keymap.set('n', '<c-j>', '<Cmd>wincmd j<CR>', { desc = 'Move to bottom window' })
keymap.set('n', '<c-k>', '<Cmd>wincmd k<CR>', { desc = 'Move to top window' })
keymap.set('n', '<c-l>', '<Cmd>wincmd l<CR>', { desc = 'Move to right window' })

-- Window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
keymap.set('n', '<leader>sx', '<Cmd>close<CR>', { desc = 'Close current split' })

------ Move lines up or down ------
-- Normal mode
keymap.set('n', '<A-k>', '<Cmd>m .-2<CR>==', { desc = 'Move line up' })
keymap.set('n', '<A-j>', '<Cmd>m .+1<CR>==', { desc = 'Move line down' })

-- Insert mode
keymap.set('i', '<A-j>', '<Esc><Cmd>m .+1<CR>==gi', { desc = 'Move line down (insert mode)' })
keymap.set('i', '<A-k>', '<Esc><Cmd>m .-2<CR>==gi', { desc = 'Move line up (insert mode)' })

-- Visual mode
keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selection down' })
keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move selection up' })

------ Window resizing ------
-- Sizing window horizontally
keymap.set('n', '<C-,>', '<C-W><', { desc = 'Resize window left' })
keymap.set('n', '<C-.>', '<C-W>>', { desc = 'Resize window right' })

-- Sizing window vertically
keymap.set('n', '<A-,>', '<C-W>5>', { desc = 'Resize window down' })
keymap.set('n', '<A-.>', '<C-W>5<', { desc = 'Resize window up' })

------ Insert new lines ------
keymap.set('n', '<C-CR>', 'mzo<Esc>`z', { desc = 'Insert new line below' })
keymap.set('n', '<S-CR>', 'mzO<Esc>`z', { desc = 'Insert new line above' })
