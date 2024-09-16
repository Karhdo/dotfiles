local M = {
  "simrat39/symbols-outline.nvim",
  config = function()
    require("symbols-outline").setup()

    vim.keymap.set('n', '<leader>to', '<cmd>SymbolsOutline<cr>', { desc = 'Toggle Symbols Outline' })
  end,
}

return M
