-- Leaders must be set before any keymap is defined, including plugin `keys`.
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

require('karhdo.core')
require('karhdo.lazy')
