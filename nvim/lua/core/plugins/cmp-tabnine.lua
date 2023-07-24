---@type LazyPlugin
local M = {
	"tzachar/cmp-tabnine",
  -- For MacOS
  -- build = "./install.sh", 
  -- For Windows
  build = "powershell ./install.ps1", 
  dependencies = 'hrsh7th/nvim-cmp'
}

return M
