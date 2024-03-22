---@type LazyPluginSpec
local M = {
	"nvim-telescope/telescope.nvim",
	enabled = not vim.g.vscode,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
	},
}

function M.config()
	local telescope = require("telescope")
	local sorters = require("telescope.sorters")

	require("core.telescope.mappings")

	telescope.setup({
		defaults = {
			find_cmd = "fd",
			path_display = { "smart" },
			layout_config = {
				prompt_position = "top",
				horizontal = { width = 0.7 },
			},
			sorting_strategy = "ascending",
			file_ignore_patterns = { "node_modules", "dist", "target" },
			file_sorter = sorters.get_fzy_sorter,
			prompt_prefix = " > ",
			color_devicons = true,
			borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
		},
		extensions = {
			media_files = {
				filetypes = { "png", "webp", "jpg", "jpeg" },
			},
		},
	})

	require("telescope").load_extension("media_files")
	require("telescope").load_extension("file_browser")
end

return M
