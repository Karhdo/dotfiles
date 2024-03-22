---@type LazyPluginSpec
local M = {
	"tzachar/cmp-tabnine",
  -- build = "./install.sh", -- For MacOS
  build = "powershell ./install.ps1", -- For Windows
  dependencies = 'hrsh7th/nvim-cmp'
}

return M
