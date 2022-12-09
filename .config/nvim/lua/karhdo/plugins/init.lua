local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

local config = karhdo.config

return require("packer").startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" })
	use({ "kyazdani42/nvim-web-devicons", config = config("devicons") }) -- File icons
	use({ "lukas-reineke/indent-blankline.nvim", config = config("indent_blankline") }) -- Indenx blankline
	use({ "nvim-lualine/lualine.nvim", config = config("lualine") }) -- Statusline
	use({ "windwp/nvim-autopairs", config = config("autopairs") }) -- Autopairs
	use({ "kyazdani42/nvim-tree.lua", tag = "nightly", config = config("nvim-tree") }) -- Folder explorer
	use({ "akinsho/bufferline.nvim", tag = "v2.*", config = config("bufferline") }) -- Buffer explorer
	use({ "xiyaowong/nvim-transparent", config = config("nvim-transparent") }) -- Remove all background colors
	use({ "folke/neodev.nvim", config = config("neodev") }) -- Setup for init.lua and plugin development
	use({ "norcalli/nvim-colorizer.lua", config = config("colorizer") }) -- Setup for init.lua and plugin development
	use({ "RRethy/vim-illuminate", config = config("illuminate") }) -- Automatically highlighting

	-- Colorschemes
	use({ "folke/tokyonight.nvim", config = config("tokyonight") }) -- Tokyonight theme

	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer", -- Buffer completions
			"hrsh7th/cmp-path", -- Path completions
			"hrsh7th/cmp-nvim-lsp", -- LSP completions
			"hrsh7th/cmp-nvim-lua", -- Lua completions
			"hrsh7th/vim-vsnip", -- LSP's snippet feature in vim
			"saadparwaiz1/cmp_luasnip", -- Shippet completions
			"rafamadriz/friendly-snippets",
			{ "tzachar/cmp-tabnine", run = "./install.sh", after = "nvim-cmp" },
		},
		config = config("cmp"),
	})

	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --Snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- A bunch of snippets to use

	--LSP
	use({ "neovim/nvim-lspconfig" }) -- Language server protocol
	use({ "onsails/lspkind-nvim", config = config("lspkind") }) -- Adds vscode-like pictograms
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "williamboman/nvim-lsp-installer" }) -- Simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- For formatters and linters

	-- Telescope
	use({ "nvim-lua/plenary.nvim" }) -- Common utilities
	use({ "nvim-telescope/telescope.nvim", config = config("telescope") })
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- Comment
	use({ "numToStr/Comment.nvim", config = config("Comment") })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"p00f/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"ShooTeX/nvim-treesitter-angular",
		},
		config = config("treesitter"),
	})
	use({ "nvim-treesitter/playground" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
