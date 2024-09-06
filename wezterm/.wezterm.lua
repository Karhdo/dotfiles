-- Pull in the wezterm API.
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font('Hack Nerd Font')
config.font_size = 16

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

config.color_scheme = 'Tokyo Night'

config.window_background_opacity = 0.7
config.macos_window_background_blur = 11

return config
