return function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"lua",
			"typescript",
		},
		sync_install = false,
		indent = {
			enable = true,
		},
		highlight = {
			enable = true,
		},
		additional_vim_regex_highlighting = false,
		textobjects = {
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["i:"] = "@prop.inner",
					["a:"] = "@prop.outer",
					["a,"] = "@comment.outer",
					["i?"] = "@conditional.inner",
					["a?"] = "@conditional.outer",
					["il"] = "@loop.inner",
					["al"] = "@loop.outer",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["ii"] = "@interface.inner",
					["ai"] = "@interface.outer",
					["aa"] = "@attribute.outer",
					["ia"] = "@attribute.inner",
				},
			},
		},
		rainbow = {
			enable = true,
			disable = { "html" },
			extended = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false, --[[`false` for Comment.nvim]]
		},
		autotag = {
			enable = true,
		},
	})
end
