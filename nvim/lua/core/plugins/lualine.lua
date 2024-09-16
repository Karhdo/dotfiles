local M = {
  "nvim-lualine/lualine.nvim",
  enabled = true,
  lazy = false,
}

function M.config()
  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = "tokyonight",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "txt" },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        { "diff", colored = true },
      },
      lualine_c = {
        { "filename", file_status = true, path = 1 },
      },
      lualine_x = {
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", file_status = true, path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "quickfix", "fugitive", "nvim-tree", "toggleterm" },
  })
end

return M
