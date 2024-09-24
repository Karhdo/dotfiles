local M = {
  "nvimtools/none-ls.nvim",
  lazy = false,
  enabled = not vim.g.vscode,
  dependencies = {
    "williamboman/mason.nvim",
    "jayp0521/mason-null-ls.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local utils = require("karhdo.lsp.utils")

    require("mason-null-ls").setup({
      automatic_installation = true,
      ensure_installed = {
        "prettierd",
        "stylelint",
        "codespell",
      },
    })

    local filetype_config = { html = { disable_format = false } }

    ---Customize null-ls attach
    ---@param client table
    ---@param bufnr  number
    local function on_attach(client, bufnr)
      utils.setup_common_mappings(client, bufnr)

      local keymap = vim.keymap
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
      local config = filetype_config[filetype] or {}

      if not config.disable_format then
        if client.server_capabilities.documentFormattingProvider then
          keymap.set('n', '<Leader><Leader>f', '<Cmd>lua vim.lsp.buf.format()<CR>', { buffer = bufnr, nowait = true })
        end

        if client.server_capabilities.documentRangeFormattingProvider then
          keymap.set('v', '<Leader><Leader>f', '<Cmd>lua vim.lsp.buf.format()<CR>', { buffer = bufnr, nowait = true })
        end
      end

      if not config.disable_rename and client.server_capabilities.renameProvider then
        keymap.set('n', '<Leader>rr', '<Cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr, nowait = true })
      end
    end

    null_ls.setup({
      on_attach = on_attach,
      sources = {
        ------------- Formatting -------------
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.nginx_beautifier,
        null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),

        ------------- Diagnostics -------------
        null_ls.builtins.diagnostics.codespell,

        ------------- Code Actions -------------
        require("none-ls.code_actions.eslint"),
      },
    })
  end,
}

return M
