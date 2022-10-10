-----------------------------------------------------------
-- Define keymaps of Neovim.
-----------------------------------------------------------
local map = karhdo.map
-- Move window
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize window
map("n", "<C-w>,", "<C-w>5<")
map("n", "<C-w>.", "<C-w>5>")
map("n", "<C-w>=", "<C-w>5+")
map("n", "<C-w>-", "<C-w>5-")

-- Split window
map("n", "<C-w>s", ":sp<CR> :wincmd j<CR>")
map("n", "<C-w>v", ":vsp<CR> :wincmd l<CR>")

-- Select all
map("n", "<C-a>", "gg<S-v>G")
