local builtin = require("telescope.builtin")

---@type string store last file u type
return function()
  local opts = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },

    file_ignore_patterns = {
      ".git",
      "node_modules",
      "dist",
      "target",
      ".settings",
      ".mvn",
      ".classpath",
      ".factorypath",
      "mvnw",
    },
  }

  builtin.live_grep(opts)
end
