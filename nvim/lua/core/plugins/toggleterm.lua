---@diagnostic disable: missing-fields
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

  local Terminal = require('toggleterm.terminal').Terminal;

  local lazygit = Terminal:new({
		count = 8,
		-- id = 101,
		cmd = "lazygit",
		shade_terminals = false,
		-- dir = "git_dir",
		direction = "float",
		hidden = true,
		float_opts = { border = "single" },
		start_in_insert = true,
		-- function to run on opening the terminal
		---@param term Terminal
		on_open = function(term)
			tnoremap({
				"<c-q>",
				function()
					term:close()
				end,
				buffer = term.bufnr,
			})
			tnoremap({ "<C-h>", "<C-h>", silent = true, buffer = term.bufnr })
			tnoremap({ "<C-j>", "<C-j>", silent = true, buffer = term.bufnr })
			tnoremap({ "<C-k>", "<C-k>", silent = true, buffer = term.bufnr })
			tnoremap({ "<C-l>", "<C-l>", silent = true, buffer = term.bufnr })
		end,
	})

  local function lazygit_toggle()
		lazygit:toggle()
	end

  mapper.nnoremap({ "<LocalLeader>gg", lazygit_toggle })
end

return M
