#!/usr/bin/env bash
# `enter` in the plugin's picker (set through @claude_fzf_options): open the
# chosen Claude in the popup over the window you are in, instead of first
# switching this terminal to the session that launched it.
#
#   claude-pick.sh <row>     row: rank \t pane \t pid \t kind \t ...
#
# fzf's become() replaces fzf with this script and picker.sh takes what it
# prints as the selection, so the plugin still does the attaching. It only
# switches session when it knows which terminal to switch (@claude_parent), so
# forget that for a popup Claude; list.sh sets it again on the next prefix+u.
# A Claude in an ordinary pane keeps the plugin's jump to that pane.

IFS=$'\t' read -r _ _ _ kind _ <<<"$1"
[ "$kind" = loose ] || tmux set-option -gu @claude_parent
printf '%s\n' "$1"
