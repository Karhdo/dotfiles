---@diagnostic disable: need-check-nil

local mapper = require("core.utils.mapper")
local map_tele = require("core.telescope.mappings")
local commander = require("core.utils.commander")
local M = {}

function M.disable_formatting(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

function M.do_cursor_hold()
	vim.lsp.buf.document_highlight()
	vim.diagnostic.open_float({
		scope = "line",
		focusable = false,
		severity_sort = true,
		close_events = {
			"BufLeave",
			"CursorMoved",
			"CursorMovedI",
			"InsertCharPre", --[[default]]
		},
	})
end

function M.setup_autocommands(client, bufnr)
	local server_capabilities = client.server_capabilities

	if server_capabilities.codeLensProvider then
		commander.augroup("LspCodeLens", {
			{
				event = { "BufEnter", "CursorHold", "InsertLeave" },
				buffer = bufnr,
				command = vim.lsp.codelens.refresh,
			},
		})
		mapper.nnoremap({ "<Leader>cl", vim.lsp.codelens.run, buffer = bufnr })
	end

	if server_capabilities.documentHighlightProvider then
		commander.augroup("LspCursorCommands", {
			{
				event = "CursorHold",
				buffer = bufnr,
				command = M.do_cursor_hold,
			},
			{
				event = { "CursorMoved", "CursorMovedI" },
				buffer = bufnr,
				command = vim.lsp.buf.clear_references,
			},
		})
	end
end

-- =============================================================================
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

	if server_capabilities.typeDefinitionProvider then
		map_tele("<Leader>gt", "lsp_type_definitions", nil, bufnr)
	end

	if server_capabilities.hoverProvider then
		nnoremap({ "K", vim.lsp.buf.hover, buffer = bufnr, nowait = true })
	end

	if server_capabilities.referencesProvider then
		nnoremap({ "gr", vim.lsp.buf.references, buffer = bufnr, nowait = true })
	end

	if server_capabilities.documentSymbolProvider then
		map_tele("go", "lsp_document_symbols", nil, bufnr)
	end

	if server_capabilities.workspaceSymbolProvider then
		map_tele("gO", "lsp_dynamic_workspace_symbols", nil, bufnr)
	end
end

---Setup mapping when an lsp attaches to a buffer
---@param client table lsp client
---@param bufnr  integer
function M.setup_mappings(client, bufnr)
	M.setup_common_mappings(client, bufnr)

	local nnoremap = mapper.nnoremap
	local vnoremap = mapper.vnoremap

	local extras = client.config and client.config.extras or {}
	local server_capabilities = client.server_capabilities

	if extras.hover then
		nnoremap({ "<Leader>K", extras.hover, buffer = bufnr, nowait = true })
	end

	if server_capabilities.codeActionProvider then
		nnoremap({ "<Leader>ca", vim.lsp.buf.code_action, buffer = bufnr, nowait = true })
		vnoremap({ "<Leader>ca", vim.lsp.buf.code_action, buffer = bufnr, nowait = true })
	end

	if server_capabilities.documentFormattingProvider then
		nnoremap({
			"<Leader><Leader>f",
			function()
				(extras.format or vim.lsp.buf.format)({ async = false })
			end,
			buffer = bufnr,
			nowait = true,
		})
	end

	if server_capabilities.documentRangeFormattingProvider then
		vnoremap({ "<Leader><Leader>f", extras.range_format or vim.lsp.buf.format, buffer = bufnr, nowait = true })
	end

	if server_capabilities.typeDefinitionProvider then
		nnoremap({ "<Leader>gd", vim.lsp.buf.type_definition, buffer = bufnr, nowait = true })
	end
end

---comment
---@param client any
---@param bufnr  number
function M.on_attach(client, bufnr)
	M.setup_autocommands(client, bufnr)
	M.setup_mappings(client, bufnr)

	local ok_status, status = PR("lsp-status")
	if ok_status then
		status.on_attach(client)
	end
end

-- =============================================================================
-- Commands
-- =============================================================================
commander.command("LspLog", function()
	vim.api.nvim_command("edit " .. vim.lsp.get_log_path())
end, {})

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
-- Setup servers
-- =============================================================================
---Logic to (re)start installed language servers for use initializing lsp
---and restart them on installing new ones
function M.setup_servers()
	local has_cmp_lsp, cmp_lsp = PR("cmp_nvim_lsp")

	local function empty_config() end

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
