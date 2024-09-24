local M = {}

-- Setup Mappings
-- =============================================================================
local float_opt = { scope = "cursor", focusable = false }

function M.diag_go_next()
  vim.diagnostic.goto_next({ float = float_opt })
end

function M.diag_go_prev()
  vim.diagnostic.goto_prev({ float = float_opt })
end

function M.diag_go_next_warn()
  vim.diagnostic.goto_next({
    severity = { min = vim.diagnostic.severity.WARN },
    float = float_opt,
  })
end

function M.diag_go_prev_warn()
  vim.diagnostic.goto_prev({
    severity = { min = vim.diagnostic.severity.WARN },
    float = float_opt,
  })
end

function M.diag_go_next_err()
  vim.diagnostic.goto_next({
    severity = vim.diagnostic.severity.ERROR,
    float = float_opt,
  })
end

function M.diag_go_prev_err()
  vim.diagnostic.goto_prev({
    severity = vim.diagnostic.severity.ERROR,
    float = float_opt,
  })
end

---Setup common mapping when an lsp attaches to a buffer
function M.setup_common_mappings(client, bufnr)
  local server_capabilities = client.server_capabilities
  local keymap = vim.keymap

  keymap.set('n', "]g", M.diag_go_next, { buffer = bufnr, nowait = true })
  keymap.set('n', "[g", M.diag_go_prev, { buffer = bufnr, nowait = true })
  keymap.set('n', "]w", M.diag_go_next_warn, { buffer = bufnr, nowait = true })
  keymap.set('n', "[w", M.diag_go_prev_warn, { buffer = bufnr, nowait = true })
  keymap.set('n', "]e", M.diag_go_next_err, { buffer = bufnr, nowait = true })
  keymap.set('n', "[e", M.diag_go_prev_err, { buffer = bufnr, nowait = true })

  if server_capabilities.renameProvider then
    keymap.set('n', "<Leader>rr", vim.lsp.buf.rename, { buffer = bufnr, nowait = true })
  end

  if server_capabilities.definitionProvider then
    keymap.set('n', "gd", vim.lsp.buf.definition, { buffer = bufnr, nowait = true })
  end

  if server_capabilities.hoverProvider then
    keymap.set('n', "K", vim.lsp.buf.hover, { buffer = bufnr, nowait = true })
  end

  if server_capabilities.referencesProvider then
    keymap.set('n', "gr", vim.lsp.buf.references, { buffer = bufnr, nowait = true })
  end
end

---Setup mapping when an lsp attaches to a buffer
---@param client table lsp client
---@param bufnr  integer
function M.setup_mappings(client, bufnr)
  M.setup_common_mappings(client, bufnr)

  local keymap = vim.keymap

  local extras = client.config and client.config.extras or {}
  local server_capabilities = client.server_capabilities

  if server_capabilities.codeActionProvider then
    keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, nowait = true })
    keymap.set('t', '<Leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, nowait = true })
  end

  if server_capabilities.documentFormattingProvider then
    keymap.set('n',
      '<Leader><Leader>f',
      function()
        (extras.format or vim.lsp.buf.format)({ async = false })
      end,
      {
        buffer = bufnr,
        nowait = true,
      })
  end

  if server_capabilities.documentRangeFormattingProvider then
    keymap.set('v', '<Leader><Leader>f', extras.range_format or vim.lsp.buf.format, { buffer = bufnr, nowait = true })
  end

  if server_capabilities.typeDefinitionProvider then
    keymap.set('n', 'Leader>gd', vim.lsp.buf.type_definition, { buffer = bufnr, nowait = true })
  end
end

---Setup mappings for lsp
---@param client any
---@param bufnr  number
function M.on_attach(client, bufnr)
  M.setup_mappings(client, bufnr)

  local ok_status, status = pcall(require, "lsp-status")

  if ok_status then
    status.on_attach(client)
  end
end

local function get_server_option(server_name)
  local has_opt, result = pcall(require, "karhdo.lsp." .. server_name) -- load config if it exists

  if has_opt then
    if type(result) == "table" then
      return result
    end

    if type(result) == "function" then
      return result()
    end
  end

  return {}
end

-- =============================================================================
-- Setup servers
-- =============================================================================
---Logic to (re)start installed language servers for use initializing lsp
---and restart them on installing new ones
function M.setup_servers()
  local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local opt = get_server_option(server_name)

      opt.on_attach = opt.on_attach or M.on_attach
      opt.capabilities = opt.capabilities or vim.lsp.protocol.make_client_capabilities()

      if has_cmp_lsp then
        opt.capabilities = cmp_lsp.default_capabilities(opt.capabilities)
      end

      require("lspconfig")[server_name].setup(opt)
    end,
    ["tsserver"] = function(server_name)
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false,            -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true,        -- fall back to standard LSP definition on failure
        },
        server = get_server_option(server_name),
      })
    end,
  })
end

return M
