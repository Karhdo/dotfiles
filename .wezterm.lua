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
local function file_exists(path)
	local f = io.open(path, "r")
	if f then
		f:close()
		return true
	end
	return false
end

-- Locate the wallpaper bundled in this repo's images/ dir so it is portable.
-- ~/.wezterm.lua is a (relative) symlink into the repo, but wezterm.config_file
-- reports the symlink path itself, so resolve one level to find the repo root.
-- Falls back to ~/Pictures/wallpaper.jpg, then to no image (solid scheme bg).
local function find_wallpaper()
	local pok, ok, stdout = pcall(wezterm.run_child_process, { "readlink", wezterm.config_file })
	if pok and ok and stdout and #stdout > 0 then
		local target = stdout:gsub("%s+$", "")
		if not target:match("^/") then
			target = wezterm.config_dir .. "/" .. target
		end
		local repo_image = target:gsub("/[^/]+$", "") .. "/images/wallpaper.jpg"
		if file_exists(repo_image) then
			return repo_image
		end
	end
	local home_image = wezterm.home_dir .. "/Pictures/wallpaper.jpg"
	if file_exists(home_image) then
		return home_image
	end
	return nil
end

local wallpaper = find_wallpaper()

config.window_background_opacity = 1.0

if wallpaper then
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
			opacity = 0.88,
		},
	}
end
-- If the wallpaper is missing (e.g. a fresh machine), we fall back to the solid
-- Tokyo Night background from color_scheme above — no transparency, no crash.

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
}

return config
