---@diagnostic disable: need-check-nil

local mapper = require("core.utils.mapper")
local M = {}

function M.disable_formatting(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

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

function M.extend_option(server_name, config)
	if not server_name then
		return config
	end
	local has_default_config, default_config = PR("lspconfig.server_configurations." .. server_name)
	if has_default_config then
		default_config = default_config.default_config
	end
	return vim.tbl_deep_extend("force", default_config, config)
end

---Setup common mapping when an lsp attaches to a buffer
---@param bufnr integer
function M.setup_common_mappings(client, bufnr)
	local server_capabilities = client.server_capabilities

	local nnoremap = mapper.nnoremap

	nnoremap({ "]g", M.diag_go_next, buffer = bufnr, nowait = true })
	nnoremap({ "[g", M.diag_go_prev, buffer = bufnr, nowait = true })
	nnoremap({ "]w", M.diag_go_next_warn, buffer = bufnr, nowait = true })
	nnoremap({ "[w", M.diag_go_prev_warn, buffer = bufnr, nowait = true })
	nnoremap({ "]e", M.diag_go_next_err, buffer = bufnr, nowait = true })
	nnoremap({ "[e", M.diag_go_prev_err, buffer = bufnr, nowait = true })

	if server_capabilities.renameProvider then
		nnoremap({ "<Leader>rr", vim.lsp.buf.rename, buffer = bufnr, nowait = true })
	end

	if server_capabilities.definitionProvider then
		nnoremap({ "gd", vim.lsp.buf.definition, buffer = bufnr, nowait = true })
	end

	if server_capabilities.hoverProvider then
    nnoremap({ "K", vim.lsp.buf.hover, buffer = bufnr, nowait = true })
	end

	if server_capabilities.referencesProvider then
		nnoremap({ "gr", vim.lsp.buf.references, buffer = bufnr, nowait = true })
	end
end

---Setup mapping when an lsp attaches to a buffer
---@param client table lsp client
---@param bufnr  integer
function M.setup_mappings(client, bufnr)
	M.setup_common_mappings(client, bufnr)

	local nnoremap = mapper.nnoremap
	local vnoremap = mapper.vnoremap

	local server_capabilities = client.server_capabilities

	if server_capabilities.codeActionProvider then
		nnoremap({ "<Leader>ca", vim.lsp.buf.code_action, buffer = bufnr, nowait = true })
		vnoremap({ "<Leader>ca", vim.lsp.buf.code_action, buffer = bufnr, nowait = true })
	end

	if server_capabilities.implementationProvider then
		nnoremap({ "gi", vim.lsp.buf.implementation, buffer = bufnr, nowait = true })
	end

	if server_capabilities.typeDefinitionProvider then
		nnoremap({ "<Leader>gd", vim.lsp.buf.type_definition, buffer = bufnr, nowait = true })
	end
end

---@param client any
---@param bufnr  number
function M.on_attach(client, bufnr)
	M.setup_mappings(client, bufnr)

	local ok_status, status = PR("lsp-status")
	if ok_status then
		status.on_attach(client)
	end

	local has_navic, navic = PR("nvim-navic")
	if has_navic and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

local function get_server_option(server_name)
	local has_opt, result = PR("core.lsp." .. server_name) -- load config if it exists

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
-- Setup servers{{{
-- =============================================================================
---Logic to (re)start installed language servers for use initializing lsp
---and restart them on installing new ones
function M.setup_servers()
	local has_cmp_lsp, cmp_lsp = PR("cmp_nvim_lsp")

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
				debug = false, -- enable debug logging for commands
				go_to_source_definition = {
					fallback = true, -- fall back to standard LSP definition on failure
				},
				server = get_server_option(server_name),
			})
		end,
	})
end

-- =============================================================================
-- Utils
-- =============================================================================
---@param filter {id: number, bufnr: number, name: string}
function M.stop_client(filter)
	local clients = vim.lsp.get_active_clients(filter)

	for _, client in ipairs(clients) do
		client.stop()
	end
end

return M
