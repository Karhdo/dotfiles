-- JSX/TSX-aware commentstring for Neovim's built-in gc/gcc.
return {
	'JoosepAlviste/nvim-ts-context-commentstring',
	event = { 'BufReadPre', 'BufNewFile' },
	-- Otherwise it registers itself as an nvim-treesitter module, which only exists
	-- on the frozen `master` branch.
	init = function()
		vim.g.skip_ts_context_commentstring_module = true
	end,
	opts = { enable_autocmd = false },
	config = function(_, opts)
		require('ts_context_commentstring').setup(opts)

		-- Built-in commenting looks commentstring up through this; on its own it
		-- picks `//` inside JSX.
		local get_option = vim.filetype.get_option
		---@diagnostic disable-next-line: duplicate-set-field
		vim.filetype.get_option = function(filetype, option)
			return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring()
				or get_option(filetype, option)
		end
	end,
}
