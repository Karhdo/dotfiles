local lsp = require("core.utils.lsp")

require("neodev").setup({
  setup_jsonls = false,
})

local M = {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", special = { ["R"] = "require", ["PR"] = "require" } },
      diagnostics = {
        globals = {
          "vim",
          "describe",
          "it",
          "before_each",
          "after_each",
          "pending",
          "clear",
          "teardown",
        },
      },
      completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
      hint = { enable = true },
      telemetry = { enable = false },
      workspace = { checkThirdParty = false },
    },
  },
  on_attach = function(client, bufnr)
    if true then
      lsp.disable_formatting(client)
      lsp.on_attach(client, bufnr)
    end
  end,
}

return M
