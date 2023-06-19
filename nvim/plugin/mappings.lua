local mapper = require("core.utils.mapper")

local nnoremap = mapper.nnoremap
local inoremap = mapper.inoremap
local vnoremap = mapper.vnoremap

------ Windows navigator ------
nnoremap({ "<c-h>", "<Cmd>wincmd h<CR>", silent = true })
nnoremap({ "<c-j>", "<Cmd>wincmd j<CR>", silent = true })
nnoremap({ "<c-k>", "<Cmd>wincmd k<CR>", silent = true })
nnoremap({ "<c-l>", "<Cmd>wincmd l<CR>", silent = true })

------ Move lines up or down ------
nnoremap({ "<A-k>", [[<Cmd>m .-2<CR>==]], silent = true })
nnoremap({ "<A-j>", [[<Cmd>m .+1<CR>==]], silent = true })

inoremap({ "<A-j>", [[<Esc><Cmd>m .+1<CR>==gi]], silent = true })
inoremap({ "<A-k>", [[<Esc><Cmd>m .-2<CR>==gi]], silent = true })

vnoremap({ "<A-j>", [[:m '>+1<CR>gv=gv]], silent = true })
vnoremap({ "<A-k>", [[:m '<-2<CR>gv=gv]], silent = true })

------ Window resizing ------
-- Sizing window horizontally
nnoremap({ "<C-,>", "<C-W><" })
nnoremap({ "<C-.>", "<C-W>>" })
-- Sizing window vertically
nnoremap({ "<A-,>", "<C-W>5<" })
nnoremap({ "<A-.>", "<C-W>5>" })

------ Insert new lines ------
nnoremap({ "<C-CR>", [[mzo<Esc>`z]], silent = true })
nnoremap({ "<S-CR>", [[mzO<Esc>`z]], silent = true })
