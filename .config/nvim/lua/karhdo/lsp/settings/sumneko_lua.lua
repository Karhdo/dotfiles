local luadev = require("lua-dev").setup({
	lspconfig = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "karhdo", "packer_bootstrap" },
				},
			},
		},
	},
})

return luadev
