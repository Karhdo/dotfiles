local M = {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  event = { "InsertEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  run = "make install_jsregexp",
}

function M.config()
  require("luasnip").config.set_config({
    history = true,
    enable_autosnippets = true,
    store_selection_keys = "<Tab>",
  })

  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").lazy_load()
end

return M
