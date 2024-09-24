local kinds = require("karhdo.core.styles").lsp.kinds

local M = {
  {
    "onsails/lspkind-nvim",
    config = function()
      require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = kinds,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    enabled = not vim.g.vscode,
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      local utils = require("karhdo.lsp.utils")
      local icons = require("karhdo.core.styles").icons.git

      vim.diagnostic.config({
        severity_sort = true,
        signs = true,
        underline = true,
        update_on_insert = false,
      })

      -- =============================================================================
      -- Signs
      -- =============================================================================
      vim.fn.sign_define({
        {
          name = "DiagnosticSignError",
          text = icons.error,
          texthl = "DiagnosticSignError",
        },
        {
          name = "DiagnosticSignHint",
          text = icons.hint,
          texthl = "DiagnosticSignHint",
        },
        {
          name = "DiagnosticSignWarn",
          text = icons.warn,
          texthl = "DiagnosticSignWarn",
        },
        {
          name = "DiagnosticSignInfo",
          text = icons.info,
          texthl = "DiagnosticSignInfo",
        },
      })

      utils.setup_servers()
    end,
  },
}

return M
