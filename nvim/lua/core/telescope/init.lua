local _M = {}

_M.search_current_folders = function()
	require("telescope.builtin").find_files({
		prompt_title = "Current Folder",
		cwd = "./",
		hidden = true,
		path_display = { shorten = 8 },
		file_ignore_patterns = { ".git/" },
	})
end

local M = setmetatable({}, {
	__index = function(_, k)
		if _M[k] then
			return _M[k]
		end

		local has_custom, custom = PR(string.format("core.telescope.custom.%s", k))
		if has_custom then
			return custom
		end

		return require("telescope.builtin")[k]
	end,
})

return M
