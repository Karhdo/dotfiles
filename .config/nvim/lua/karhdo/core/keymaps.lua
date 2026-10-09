-- Editor keymaps that don't belong to a plugin. Plugin keymaps live in the
-- plugin's spec (`keys`), buffer-local ones in their attach callback.
local map = vim.keymap.set

map('n', '<leader>nh', '<Cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Windows
map('n', '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Go to left window' })
map('n', '<C-j>', '<Cmd>wincmd j<CR>', { desc = 'Go to lower window' })
map('n', '<C-k>', '<Cmd>wincmd k<CR>', { desc = 'Go to upper window' })
map('n', '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Go to right window' })

map('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically' })
map('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally' })
map('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' })
map('n', '<leader>sx', '<Cmd>close<CR>', { desc = 'Close current split' })

map('n', '<C-,>', '<C-w><', { desc = 'Decrease window width' })
map('n', '<C-.>', '<C-w>>', { desc = 'Increase window width' })
map('n', '<A-,>', '<C-w>5>', { desc = 'Increase window width by 5' })
map('n', '<A-.>', '<C-w>5<', { desc = 'Decrease window width by 5' })

-- Move lines. Visual mode uses `:` rather than <Cmd> so the '< '> marks are set.
map('n', '<A-j>', '<Cmd>m .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', '<Cmd>m .-2<CR>==', { desc = 'Move line up' })
map('i', '<A-j>', '<Esc><Cmd>m .+1<CR>==gi', { desc = 'Move line down' })
map('i', '<A-k>', '<Esc><Cmd>m .-2<CR>==gi', { desc = 'Move line up' })
map('x', '<A-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selection down' })
map('x', '<A-k>', ':m \'<-2<CR>gv=gv', { desc = 'Move selection up' })

-- Blank lines, keeping the cursor where it is
map('n', '<C-CR>', 'mzo<Esc>`z', { desc = 'Insert blank line below' })
map('n', '<S-CR>', 'mzO<Esc>`z', { desc = 'Insert blank line above' })
