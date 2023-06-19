local M = {
  icons = {
    error = "✗",
    warn = "",
    info = "",
    hint = "",
    git = {
      add = "┃",
      change = "┃",
      delete = "┃",
      top_delete = "┃",
      change_delete = "┃",
    },
  },
  lsp = {
    kinds = {
      Boolean = "◩ ",
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = "練",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Namespace = " ",
      Operator = " ",
      Property = "襁",
      Reference = " ",
      Snippet = " ",
      Struct = "פּ ",
      Text = " ",
      TypeParameter = "",
      Unit = "塞",
      Value = " ",
      Variable = " ",
    },
  },
-- TODO: use other colors
  palette = {
    pale_red = "#E06C75",
    dark_red = "#be5046",
    light_red = "#c43e1f",
    dark_orange = "#FF922B",
    green = "#98c379",
    bright_yellow = "#FAB005",
    light_yellow = "#e5c07b",
    dark_blue = "#4e88ff",
    magenta = "#c678dd",
    comment_grey = "#5c6370",
    grey = "#3E4556",
    whitesmoke = "#626262",
    bright_blue = "#51afef",
    teal = "#15AABF",
  },
  border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
}

return M
