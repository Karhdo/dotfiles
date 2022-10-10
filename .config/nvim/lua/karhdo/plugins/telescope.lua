return function()
	local fb_actions = require("telescope").extensions.file_browser.actions
	local builtin = require("telescope.builtin")

	require("telescope").setup({
		defaults = {
			find_cmd = "fd",
			color_devicons = true,
			path_display = { "smart" },
			sorting_strategy = "ascending",
			layout_config = { prompt_position = "top", horizontal = { width = 0.88 } },
			mappings = {
				n = {
					["q"] = require("telescope.actions").close,
				},
			},
			file_ignore_patterns = {
				-- nodejs
				"node_modules",
				"dist",
				-- java
				"target",
			},
		},
		extensions = {
			file_browser = {
				theme = "dropdown",
				hijack_netrw = true, -- Disables netrw and use telescope-file-browser in its place
				mappings = {
					["n"] = {
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
					},
				},
			},
		},
	})

	require("telescope").load_extension("file_browser")

	-- Custom key maps
	local map = karhdo.map

	map("n", "<Space>f", function()
		builtin.find_files()
	end)

	map("n", "<Space>c", function()
		builtin.find_files({
			prompt_title = "Current Directory",
			cwd = vim.fn.expand("%:p:h"),
		})
	end)

	map("n", "<Space>b", function()
		fb_actions.file_browser({
			path = "%:p:h",
			cwd = vim.fn.expand("%:p:h"),
			respect_gitignore = false,
			hidden = true,
			grouped = true,
			previewer = false,
			initial_mode = "normal",
			layout_config = { height = 40 },
		})
	end)
end
