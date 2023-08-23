---@diagnostic disable: missing-fields
local commander = require("core.utils.commander")

commander.augroup("TextYankHighlight", {
	{
		-- don't execute silently in case of errors
		event = "TextYankPost",
		pattern = "*",
		command = function()
			vim.highlight.on_yank({
				on_visual = false,
				higroup = "DiffText",
			})
		end,
	},
})

commander.augroup("VimrcIncSearchHighlight", {
	{
		-- automatically clear search highlight once leaving the commandline
		event = "CmdlineEnter",
		pattern = "[/\\?]",
		command = [[:set hlsearch  | redrawstatus]],
	},
	{
		event = "CmdlineLeave",
		pattern = "[/\\?]",
		command = ":set nohlsearch | redrawstatus",
	},
})
