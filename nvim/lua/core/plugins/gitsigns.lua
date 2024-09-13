---@type LazyPluginSpec
local M = {
	"lewis6991/gitsigns.nvim",
}

M.config = function()
  require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_formatter = '      <author>, <author_time:%R> • <summary>',
    current_line_blame_opts = {
      delay = 100,  -- Delay before showing blame, in milliseconds
      virt_text_pos = 'eol',  -- Position of virtual text (end of line)
    },
  })
end

return M
