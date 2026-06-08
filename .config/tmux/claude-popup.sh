#!/usr/bin/env bash
# Open (or attach) a per-repo Claude CLI session inside a tmux popup.
#
# The popup's working directory is the launching pane's path, set by the
# binding via `display-popup -d "#{pane_current_path}"` (tmux only expands
# the #{...} format for popup FLAGS, never for the -E shell-command — so we
# read the path from $PWD here rather than from an argument).
#
# The tmux session name is derived from the git repo root of $PWD, so each
# repo gets its own long-lived `claude-<repo>` session: conversations/context
# stay separate per project and survive closing/reopening the popup.
#
# Binding:  bind-key a display-popup -E -d "#{pane_current_path}" \
#             "$HOME/.config/tmux/claude-popup.sh"

# Resolve the git repo root of the popup's directory; fall back to $PWD.
root="$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null || echo "$PWD")"

# tmux session names may not contain '.', ':' or '#' — sanitise them.
base="$(basename "$root" | tr '.:#' '___')"
[ -z "$base" ] && base="default"
name="claude-$base"

# Create the session (detached) on first use, then always attach to it.
# `=name` forces an exact match. No `set -e`: a non-fatal hiccup in any
# single command must never tear the whole popup down.
tmux has-session -t "=$name" 2>/dev/null || tmux new-session -d -s "$name" -c "$root" "claude --dangerously-skip-permissions"

# Keep the popup tidy: no status bar for these sessions.
tmux set-option -t "=$name" status off

exec tmux attach-session -t "=$name"
