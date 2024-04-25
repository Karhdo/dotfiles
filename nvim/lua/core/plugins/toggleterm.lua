---@type LazyPluginSpec
local M = {
  "akinsho/toggleterm.nvim",
}

function M.config()
  local toggleterm = require("toggleterm");
  local border = require("core.global.style").border;

  toggleterm.setup({
    open_mapping = [[<c-\>]],
    close_on_exit = true, -- Close the terminal window when the process exits
    shell = vim.o.shell, -- Change the default shell. Can be a string or a function returning a string
    float_opts = {
      border = border,
      highlight = {
        border = "Normal",
        background = "Terminal"
      }
    }
  })

  local mapper = require('core.utils.mapper');
  local tnoremap = mapper.tnoremap;

  local function set_terminal_keymaps(event)
    tnoremap({
			"<C-h>",
			"<C-\\><C-n><Cmd>lua require'Navigator'.left()<CR>",
			buffer = event.buf,
		})
		tnoremap({
			"<C-k>",
			"<C-\\><C-n><Cmd>lua require'Navigator'.up()<CR>",
			buffer = event.buf,
		})
		tnoremap({
			"<C-j>",
			"<C-\\><C-n><Cmd>lua require'Navigator'.down()<CR>",
			buffer = event.buf,
		})
		tnoremap({
			"<C-l>",
			"<C-\\><C-n><Cmd>lua require'Navigator'.right()<CR>",
			buffer = event.buf,
		})
  end

  vim.api.nvim_create_autocmd("TermOpen", {
		pattern = "term://*",
		callback = set_terminal_keymaps,
	})
end

return M
