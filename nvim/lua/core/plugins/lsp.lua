local kinds = require("core.global.style").lsp.kinds

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
      local lsp = require("core.utils.lsp")
      local icons = require("core.global.style").icons.git

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

      lsp.setup_servers()
    end,
  },
  {
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
      local lsp = require("core.utils.lsp")

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
        lsp.setup_common_mappings(client, bufnr)

        local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
        local config = filetype_config[filetype] or {}
        local mapper = require("core.utils.mapper")

        if not config.disable_format then
          if client.server_capabilities.documentFormattingProvider then
            mapper.nnoremap({
              "<Leader><Leader>f",
              vim.lsp.buf.format,
              buffer = bufnr,
              nowait = true,
            })
          end

          if client.server_capabilities.documentRangeFormattingProvider then
            mapper.vnoremap({
              "<Leader><Leader>f",
              vim.lsp.buf.format,
              buffer = bufnr,
              nowait = true,
            })
          end
        end

        if not config.disable_rename and client.server_capabilities.renameProvider then
          mapper.nnoremap({
            "<Leader>rr",
            vim.lsp.buf.rename,
            buffer = bufnr,
            nowait = true,
          })
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
          require("none-ls.diagnostics.eslint"),

          ------------- Code Actions -------------
          require("none-ls.code_actions.eslint"),
        },
      })
    end,
  },
}

return M
