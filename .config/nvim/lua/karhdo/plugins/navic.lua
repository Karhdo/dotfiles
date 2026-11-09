-- Winbar breadcrumbs (file > LSP symbol), drawn by core/winbar.lua.
local winbar = '%{%v:lua.require\'karhdo.core.winbar\'.render()%}'

local function is_file_window()
	return vim.fn.win_gettype() == ''
		and vim.bo.buftype == ''
		and vim.bo.filetype ~= 'gitcommit'
		and vim.api.nvim_buf_get_name(0) ~= ''
end

return {
	'SmiteshP/nvim-navic',
	-- Before the first LspAttach, so auto_attach sees it.
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = { 'nvim-mini/mini.icons', 'onsails/lspkind.nvim' },
	opts = function()
		-- Same symbols as the completion menu; navic wants a trailing space.
		local icons = {}
		for kind, symbol in pairs(require('lspkind').presets.default) do
			icons[kind] = symbol .. ' '
		end

		return {
			lsp = { auto_attach = true },
			highlight = true,
			separator = ' > ',
			icons = icons,
			depth_limit = 5,
		}
	end,
	config = function(_, opts)
		require('nvim-navic').setup(opts)

		-- Set per window on entry rather than refreshed on a timer, so codediff can clear
		-- or title its own panes' winbars without being overwritten.
		vim.api.nvim_create_autocmd('BufWinEnter', {
			group = vim.api.nvim_create_augroup('KarhdoWinbar', { clear = true }),
			callback = function()
				if vim.w.codediff_restore then
					return
				end
				if is_file_window() then
					vim.api.nvim_set_option_value('winbar', winbar, { scope = 'local' })
				elseif vim.wo.winbar == winbar then
					-- The window switched away from a file; leave other plugins' winbars alone.
					vim.api.nvim_set_option_value('winbar', '', { scope = 'local' })
				end
			end,
		})
	end,
}
