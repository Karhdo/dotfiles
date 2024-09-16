local lsp = require("core.utils.lsp")

local M = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  on_attach = function(client, bufnr)
    lsp.on_attach(client, bufnr)
  end,
}

return M
