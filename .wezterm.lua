-- Pull in the wezterm API.
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- use_ime uses the macOS input method editor for complex character input.
config.use_ime = true

-- Send a real Alt/Meta to the terminal when the LEFT Option key is pressed
-- (instead of composing accented characters), so tmux Alt bindings like the
-- Claude popup toggle (M-a) work. The RIGHT Option key still composes glyphs.
config.send_composed_key_when_left_alt_is_pressed = false

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.5
config.line_height = 1.2

config.enable_tab_bar = false

-- config.window_decorations = "TITLE | RESIZE"
config.window_decorations = "RESIZE"

config.color_scheme = "Tokyo Night"

-- Background: render a wallpaper INSIDE the terminal with a dark overlay on top,
-- instead of relying on window transparency. This keeps the look consistent no
-- matter what app sits behind the window (transparency showed through and looked
-- messy over other apps). Opacity is 1.0 so nothing behind bleeds through.
--
-- Tweakables: image `brightness` (lower = darker wallpaper) and overlay `opacity`
-- (higher = darker, more text contrast). Swap `wallpaper` for any image you like.
local wallpaper = wezterm.home_dir .. "/Pictures/wallpaper.jpg"

local function file_exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

config.window_background_opacity = 1.0

if file_exists(wallpaper) then
	config.background = {
		{
			source = { File = wallpaper },
			hsb = { brightness = 0.12, saturation = 1.0, hue = 1.0 },
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
		{
			source = { Color = "#1a1b26" }, -- Tokyo Night bg, semi-opaque overlay
			width = "100%",
			height = "100%",
			opacity = 0.85,
		},
	}
end
-- If the wallpaper is missing (e.g. a fresh machine), we fall back to the solid
-- Tokyo Night background from color_scheme above — no transparency, no crash.

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
}

return config
