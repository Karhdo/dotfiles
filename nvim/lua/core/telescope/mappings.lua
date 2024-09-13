TelescopeMapArgs = TelescopeMapArgs or {}

local should_reload = false

---replace_termcodes
---@param str string
---@return string
local function replace_termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function map_tele(lhs, rhs, options, buffer, mode)
	local map_key = replace_termcodes(lhs .. rhs .. (buffer or ""))

	TelescopeMapArgs[map_key] = options or {}

	mode = mode or "n"
	rhs = string.format(
		should_reload and "<Cmd>lua pcall(require('core.telescope')['%s'],TelescopeMapArgs['%s'])<CR>"
			or "<Cmd>lua pcall(require('core.telescope')['%s'],TelescopeMapArgs['%s'])<CR>",
		rhs,
		map_key
	)

	local map_opts = { noremap = true, silent = true, nowait = true, buffer = buffer }

	vim.keymap.set(mode, lhs, rhs, map_opts)
end

map_tele(";b", "buffers")
map_tele(";r", "live_grep")
map_tele(";o", "oldfiles")
map_tele(";f", "search_current_folders")

return map_tele
