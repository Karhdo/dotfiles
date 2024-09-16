local lsp = require("core.utils.lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {
  settings = {
    typescript = {
      surveys = { enabled = false },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      surveys = { enabled = false },
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
  init_options = {
    preferences = {
      allowJs = true,
      quotePreference = "auto", -- "auto" | "double" | "single";
      importModuleSpecifierPreference = "non-relative",
      includeCompletionsForImportStatements = true,
      includeAutomaticOptionalChainCompletions = true,
    },
  },
  capabilities = capabilities,
}

vim.api.nvim_command([[command! TsImportAll TypescriptAddMissingImports]])
vim.api.nvim_command([[command! TsOrgImports TypescriptOrganizeImports]])

function M.on_attach(client, bufnr)
  local clients = vim.lsp.get_active_clients({ name = "denols" })

  if #clients > 0 then
    client.stop()
    return
  end

  local mapper = require("core.utils.mapper")

  if vim.g.use_eslint or vim.g.use_prettier then
    lsp.disable_formatting(client)
  end
  lsp.on_attach(client, bufnr)

  mapper.nnoremap({ "gd", "<Cmd>TypescriptGoToSourceDefinition<CR>", buffer = bufnr })
end

return M
