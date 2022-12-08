-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/trongkhanh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/trongkhanh/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/trongkhanh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/trongkhanh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/trongkhanh/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\në\3\0\0\6\0\17\0\0316\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0\18\1\0\0'\3\b\0'\4\t\0'\5\n\0B\1\4\1\18\1\0\0'\3\b\0'\4\v\0'\5\f\0B\1\4\1\18\1\0\0'\3\b\0'\4\r\0'\5\14\0B\1\4\1\18\1\0\0'\3\b\0'\4\15\0'\5\16\0B\1\4\1K\0\1\0!<Cmd>BufferLineCloseLeft<CR>\16<Leader>bcl\"<Cmd>BufferLineCloseRight<CR>\16<Leader>bcr!<Cmd>BufferLineCyclePrev<CR>\f<S-Tab>!<Cmd>BufferLineCycleNext<CR>\n<Tab>\6n\bmap\vkarhdo\foptions\1\0\0\1\0\3\16diagnostics\rnvim_lsp\23left_mouse_command\14buffer %d\16color_icons\2\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tabnine"] = {
    after_files = { "/Users/trongkhanh/.local/share/nvim/site/pack/packer/opt/cmp-tabnine/after/plugin/cmp-tabnine.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/opt/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\nó\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\rProperty\bÔ∞†\nClass\bÔ¥Ø\vModule\bÔíá\rConstant\bÔ£æ\14Interface\bÔÉ®\vStruct\bÔ≠Ñ\rFunction\bÔûî\18TypeParameter\5\rVariable\bÔî™\rOperator\bÔöî\nField\bÔ∞†\nEvent\bÔÉß\16Constructor\bÔê£\15EnumMember\bÔÖù\vMethod\bÔö¶\vFolder\bÔùä\tText\bÔùæ\14Reference\bÔúÜ\tFile\bÔúò\nColor\bÔ£ó\fSnippet\bÔëè\tEnum\bÔÖù\nValue\bÔ¢ü\fKeyword\bÔ†ä\tUnit\bÔ•¨\1\0\2\vpreset\rcodicons\tmode\16symbol_text\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nè\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\3\0\0\vpacker\rNVimTree\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneodev\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-tabnine" },
    config = { "\27LJ\2\n-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\3¿\tbody\15lsp_expand≥\a\1\0\14\0)\0K6\0\0\0006\2\1\0'\3\2\0B\0\3\0036\2\0\0006\4\1\0'\5\3\0B\2\3\0036\4\0\0006\6\1\0'\a\4\0B\4\3\3\15\0\0\0X\6\4Ä\15\0\2\0X\6\2Ä\14\0\4\0X\6\1Ä2\0007Ä5\6\5\0006\a\1\0'\t\6\0B\a\2\0029\a\a\aB\a\1\0019\a\b\0015\t\f\0005\n\n\0003\v\t\0=\v\v\n=\n\r\t5\n\16\0009\v\14\0019\v\15\vB\v\1\2=\v\17\n9\v\14\0019\v\18\vB\v\1\2=\v\19\n9\v\14\0019\v\20\v5\r\21\0B\v\2\2=\v\22\n=\n\14\t5\n\26\0009\v\23\0055\r\24\0=\6\25\rB\v\2\2=\v\27\n=\n\28\t4\n\6\0005\v\29\0>\v\1\n5\v\30\0>\v\2\n5\v\31\0>\v\3\n5\v \0>\v\4\n5\v!\0>\v\5\n=\n\"\t5\n&\0005\v$\0005\f#\0=\f%\v=\v'\n=\n(\tB\a\2\0012\0\0ÄK\0\1\0K\0\1\0\vwindow\18documentation\1\0\0\vborder\1\0\0\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\2\19max_item_count\3\2\tname\16cmp_tabnine\1\0\2\19max_item_count\3\4\tname\fluasnip\1\0\2\19max_item_count\3\4\tname\rnvim_lsp\15formatting\vformat\1\0\0\tmenu\1\0\2\rmaxwidth\0032\14with_text\2\15cmp_format\n<Tab>\1\0\2\rmaxwidth\0032\vselect\2\fconfirm\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\14lazy_load luasnip/loaders/from_vscode\1\0\f\tjira\v[Jira]\vcrates\r[Crates]\tpath\v[Path]\bnpm\n[NPM]\fluasnip\14[LuaSnip]\16cmp_tabnine\v[Tab9]\nspell\f[Spell]\nemoji\f[Emoji]\forgmode\n[Org]\vbuffer\r[Buffer]\tcalc\v[Calc]\rnvim_lsp\n[LSP]\flspkind\fluasnip\bcmp\frequire\npcall\0" },
    loaded = true,
    only_config = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\2\nÒ\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\a\0\0\23BufferLineTabClose\29BufferlineBufferSelected\19BufferLineFill\25BufferLineBackground\24BufferLineSeparator BufferLineIndicatorSelected\1\0\1\venable\2\nsetup\16transparent\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\nÊ\1\0\0\6\0\r\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0\18\1\0\0'\3\b\0'\4\t\0'\5\n\0B\1\4\1\18\1\0\0'\3\b\0'\4\v\0'\5\f\0B\1\4\1K\0\1\0\26:NvimTreeFindFile<CR>\14<Leader>n\24:NvimTreeToggle<CR>\n<C-n>\6n\bmap\vkarhdo\tview\1\0\1\tside\nright\1\0\1\25auto_reload_on_write\1\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÒ\5\0\0\6\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\r\0005\4\n\0005\5\v\0=\5\f\4=\4\14\3=\3\15\0025\3\16\0005\4\17\0=\4\18\3=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\fautotag\1\0\1\venable\2\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\frainbow\fdisable\1\2\0\0\thtml\1\0\2\rextended\2\venable\2\16textobjects\vselect\1\0\0\fkeymaps\1\0\17\aic\17@class.inner\aai\21@interface.outer\aif\20@function.inner\aii\21@interface.inner\aaa\21@attribute.outer\aib\17@block.inner\aab\17@block.outer\aac\17@class.outer\aaf\20@function.outer\aia\21@attribute.inner\ail\16@loop.inner\aa?\23@conditional.outer\aal\16@loop.outer\ai?\23@conditional.inner\aa,\19@comment.outer\aa:\16@prop.outer\ai:\16@prop.inner\1\0\2\14lookahead\2\venable\2\14highlight\1\0\1\venable\2\vindent\1\0\1\venable\2\21ensure_installed\1\0\2\17sync_install\1&additional_vim_regex_highlighting\1\1\3\0\0\blua\15typescript\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-angular"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-angular",
    url = "https://github.com/ShooTeX/nvim-treesitter-angular"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\15find_filesz\0\0\6\1\a\0\v-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\2B\0\2\1K\0\1\0\1¿\bcwd\n%:p:h\vexpand\afn\bvim\1\0\1\17prompt_title\22Current Directory\15find_filesÕ\1\0\0\6\1\t\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\0¿\18layout_config\1\0\1\vheight\3(\bcwd\n%:p:h\vexpand\afn\bvim\1\0\6\17initial_mode\vnormal\tpath\n%:p:h\fgrouped\2\22respect_gitignore\1\14previewer\1\vhidden\2\17file_browserÁ\5\1\0\v\0*\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\4\0006\1\0\0'\3\5\0B\1\2\0026\2\0\0'\4\1\0B\2\2\0029\2\6\0025\4\23\0005\5\a\0005\6\b\0=\6\t\0055\6\n\0005\a\v\0=\a\f\6=\6\r\0055\6\18\0005\a\16\0006\b\0\0'\n\14\0B\b\2\0029\b\15\b=\b\17\a=\a\19\6=\6\20\0055\6\21\0=\6\22\5=\5\24\0045\5 \0005\6\25\0005\a\31\0005\b\27\0009\t\26\0=\t\28\b9\t\29\0=\t\30\b=\b\19\a=\a\20\6=\6\3\5=\5\2\4B\2\2\0016\2\0\0'\4\1\0B\2\2\0029\2!\2'\4\3\0B\2\2\0016\2\"\0009\2#\2\18\3\2\0'\5\19\0'\6$\0003\a%\0B\3\4\1\18\3\2\0'\5\19\0'\6&\0003\a'\0B\3\4\1\18\3\2\0'\5\19\0'\6(\0003\a)\0B\3\4\0012\0\0ÄK\0\1\0\0\r<Space>b\0\r<Space>c\0\r<Space>f\bmap\vkarhdo\19load_extension\1\0\0\1\0\0\6h\20goto_parent_dir\6N\1\0\0\vcreate\1\0\2\17hijack_netrw\2\ntheme\rdropdown\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\17node_modules\tdist\vtarget\rmappings\6n\1\0\0\6q\1\0\0\nclose\22telescope.actions\18layout_config\15horizontal\1\0\1\nwidth\4©∏Ωî\fı—∞ˇ\3\1\0\1\20prompt_position\btop\17path_display\1\2\0\0\nsmart\1\0\3\21sorting_strategy\14ascending\19color_devicons\2\rfind_cmd\afd\nsetup\22telescope.builtin\factions\17file_browser\15extensions\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16transparent\2\nstyle\tmoon\nsetup\15tokyonight\frequire\0" },
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/Users/trongkhanh/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\nó\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\rProperty\bÔ∞†\nClass\bÔ¥Ø\vModule\bÔíá\rConstant\bÔ£æ\14Interface\bÔÉ®\vStruct\bÔ≠Ñ\rFunction\bÔûî\18TypeParameter\5\rVariable\bÔî™\rOperator\bÔöî\nField\bÔ∞†\nEvent\bÔÉß\16Constructor\bÔê£\15EnumMember\bÔÖù\vMethod\bÔö¶\vFolder\bÔùä\tText\bÔùæ\14Reference\bÔúÜ\tFile\bÔúò\nColor\bÔ£ó\fSnippet\bÔëè\tEnum\bÔÖù\nValue\bÔ¢ü\fKeyword\bÔ†ä\tUnit\bÔ•¨\1\0\2\vpreset\rcodicons\tmode\16symbol_text\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\në\3\0\0\6\0\17\0\0316\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0\18\1\0\0'\3\b\0'\4\t\0'\5\n\0B\1\4\1\18\1\0\0'\3\b\0'\4\v\0'\5\f\0B\1\4\1\18\1\0\0'\3\b\0'\4\r\0'\5\14\0B\1\4\1\18\1\0\0'\3\b\0'\4\15\0'\5\16\0B\1\4\1K\0\1\0!<Cmd>BufferLineCloseLeft<CR>\16<Leader>bcl\"<Cmd>BufferLineCloseRight<CR>\16<Leader>bcr!<Cmd>BufferLineCyclePrev<CR>\f<S-Tab>!<Cmd>BufferLineCycleNext<CR>\n<Tab>\6n\bmap\vkarhdo\foptions\1\0\0\1\0\3\16diagnostics\rnvim_lsp\23left_mouse_command\14buffer %d\16color_icons\2\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\3¿\tbody\15lsp_expand≥\a\1\0\14\0)\0K6\0\0\0006\2\1\0'\3\2\0B\0\3\0036\2\0\0006\4\1\0'\5\3\0B\2\3\0036\4\0\0006\6\1\0'\a\4\0B\4\3\3\15\0\0\0X\6\4Ä\15\0\2\0X\6\2Ä\14\0\4\0X\6\1Ä2\0007Ä5\6\5\0006\a\1\0'\t\6\0B\a\2\0029\a\a\aB\a\1\0019\a\b\0015\t\f\0005\n\n\0003\v\t\0=\v\v\n=\n\r\t5\n\16\0009\v\14\0019\v\15\vB\v\1\2=\v\17\n9\v\14\0019\v\18\vB\v\1\2=\v\19\n9\v\14\0019\v\20\v5\r\21\0B\v\2\2=\v\22\n=\n\14\t5\n\26\0009\v\23\0055\r\24\0=\6\25\rB\v\2\2=\v\27\n=\n\28\t4\n\6\0005\v\29\0>\v\1\n5\v\30\0>\v\2\n5\v\31\0>\v\3\n5\v \0>\v\4\n5\v!\0>\v\5\n=\n\"\t5\n&\0005\v$\0005\f#\0=\f%\v=\v'\n=\n(\tB\a\2\0012\0\0ÄK\0\1\0K\0\1\0\vwindow\18documentation\1\0\0\vborder\1\0\0\1\t\0\0\b‚ï≠\b‚îÄ\b‚ïÆ\b‚îÇ\b‚ïØ\b‚îÄ\b‚ï∞\b‚îÇ\fsources\1\0\1\tname\tpath\1\0\1\tname\vbuffer\1\0\2\19max_item_count\3\2\tname\16cmp_tabnine\1\0\2\19max_item_count\3\4\tname\fluasnip\1\0\2\19max_item_count\3\4\tname\rnvim_lsp\15formatting\vformat\1\0\0\tmenu\1\0\2\rmaxwidth\0032\14with_text\2\15cmp_format\n<Tab>\1\0\2\rmaxwidth\0032\vselect\2\fconfirm\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\14lazy_load luasnip/loaders/from_vscode\1\0\f\tjira\v[Jira]\vcrates\r[Crates]\tpath\v[Path]\bnpm\n[NPM]\fluasnip\14[LuaSnip]\16cmp_tabnine\v[Tab9]\nspell\f[Spell]\nemoji\f[Emoji]\forgmode\n[Org]\vbuffer\r[Buffer]\tcalc\v[Calc]\rnvim_lsp\n[LSP]\flspkind\fluasnip\bcmp\frequire\npcall\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: neodev.nvim
time([[Config for neodev.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneodev\frequire\0", "config", "neodev.nvim")
time([[Config for neodev.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n@\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nè\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0005\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\23disabled_filetypes\1\3\0\0\vpacker\rNVimTree\1\0\1\ntheme\15tokyonight\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nÊ\1\0\0\6\0\r\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0\18\1\0\0'\3\b\0'\4\t\0'\5\n\0B\1\4\1\18\1\0\0'\3\b\0'\4\v\0'\5\f\0B\1\4\1K\0\1\0\26:NvimTreeFindFile<CR>\14<Leader>n\24:NvimTreeToggle<CR>\n<C-n>\6n\bmap\vkarhdo\tview\1\0\1\tside\nright\1\0\1\25auto_reload_on_write\1\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n$\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\15find_filesz\0\0\6\1\a\0\v-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\2B\0\2\1K\0\1\0\1¿\bcwd\n%:p:h\vexpand\afn\bvim\1\0\1\17prompt_title\22Current Directory\15find_filesÕ\1\0\0\6\1\t\0\r-\0\0\0009\0\0\0005\2\1\0006\3\2\0009\3\3\0039\3\4\3'\5\5\0B\3\2\2=\3\6\0025\3\a\0=\3\b\2B\0\2\1K\0\1\0\0¿\18layout_config\1\0\1\vheight\3(\bcwd\n%:p:h\vexpand\afn\bvim\1\0\6\17initial_mode\vnormal\tpath\n%:p:h\fgrouped\2\22respect_gitignore\1\14previewer\1\vhidden\2\17file_browserÁ\5\1\0\v\0*\0G6\0\0\0'\2\1\0B\0\2\0029\0\2\0009\0\3\0009\0\4\0006\1\0\0'\3\5\0B\1\2\0026\2\0\0'\4\1\0B\2\2\0029\2\6\0025\4\23\0005\5\a\0005\6\b\0=\6\t\0055\6\n\0005\a\v\0=\a\f\6=\6\r\0055\6\18\0005\a\16\0006\b\0\0'\n\14\0B\b\2\0029\b\15\b=\b\17\a=\a\19\6=\6\20\0055\6\21\0=\6\22\5=\5\24\0045\5 \0005\6\25\0005\a\31\0005\b\27\0009\t\26\0=\t\28\b9\t\29\0=\t\30\b=\b\19\a=\a\20\6=\6\3\5=\5\2\4B\2\2\0016\2\0\0'\4\1\0B\2\2\0029\2!\2'\4\3\0B\2\2\0016\2\"\0009\2#\2\18\3\2\0'\5\19\0'\6$\0003\a%\0B\3\4\1\18\3\2\0'\5\19\0'\6&\0003\a'\0B\3\4\1\18\3\2\0'\5\19\0'\6(\0003\a)\0B\3\4\0012\0\0ÄK\0\1\0\0\r<Space>b\0\r<Space>c\0\r<Space>f\bmap\vkarhdo\19load_extension\1\0\0\1\0\0\6h\20goto_parent_dir\6N\1\0\0\vcreate\1\0\2\17hijack_netrw\2\ntheme\rdropdown\rdefaults\1\0\0\25file_ignore_patterns\1\4\0\0\17node_modules\tdist\vtarget\rmappings\6n\1\0\0\6q\1\0\0\nclose\22telescope.actions\18layout_config\15horizontal\1\0\1\nwidth\4©∏Ωî\fı—∞ˇ\3\1\0\1\20prompt_position\btop\17path_display\1\2\0\0\nsmart\1\0\3\21sorting_strategy\14ascending\19color_devicons\2\rfind_cmd\afd\nsetup\22telescope.builtin\factions\17file_browser\15extensions\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÒ\5\0\0\6\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\r\0005\4\n\0005\5\v\0=\5\f\4=\4\14\3=\3\15\0025\3\16\0005\4\17\0=\4\18\3=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\fautotag\1\0\1\venable\2\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\frainbow\fdisable\1\2\0\0\thtml\1\0\2\rextended\2\venable\2\16textobjects\vselect\1\0\0\fkeymaps\1\0\17\aic\17@class.inner\aai\21@interface.outer\aif\20@function.inner\aii\21@interface.inner\aaa\21@attribute.outer\aib\17@block.inner\aab\17@block.outer\aac\17@class.outer\aaf\20@function.outer\aia\21@attribute.inner\ail\16@loop.inner\aa?\23@conditional.outer\aal\16@loop.outer\ai?\23@conditional.inner\aa,\19@comment.outer\aa:\16@prop.outer\ai:\16@prop.inner\1\0\2\14lookahead\2\venable\2\14highlight\1\0\1\venable\2\vindent\1\0\1\venable\2\21ensure_installed\1\0\2\17sync_install\1&additional_vim_regex_highlighting\1\1\3\0\0\blua\15typescript\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\16transparent\2\nstyle\tmoon\nsetup\15tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\2\nÒ\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\fexclude\17extra_groups\1\a\0\0\23BufferLineTabClose\29BufferlineBufferSelected\19BufferLineFill\25BufferLineBackground\24BufferLineSeparator BufferLineIndicatorSelected\1\0\1\venable\2\nsetup\16transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd cmp-tabnine ]]
time([[Sequenced loading]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
