local utils = require("karhdo.lsp.utils")

local M = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  on_attach = function(client, bufnr)
    utils.on_attach(client, bufnr)
  end,
}

return M
