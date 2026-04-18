-- Pull in the wezterm API.
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- use_ime uses the macOS input method editor for complex character input.
config.use_ime = true

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.5
config.line_height = 1.2

config.enable_tab_bar = false

-- config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "RESIZE"

config.color_scheme = "Tokyo Night"

config.window_background_opacity = 0.93
config.macos_window_background_blur = 26

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
}

return config
