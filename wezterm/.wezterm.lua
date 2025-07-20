-- Pull in the wezterm API.
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 20

config.enable_tab_bar = false

-- config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "RESIZE"

config.color_scheme = 'Tokyo Night'

config.window_background_opacity = 0.93
config.macos_window_background_blur = 26

return config
