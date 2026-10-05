#!/usr/bin/env bash
# Open (or reattach to) one tmux-claude-hatch Claude for the whole "org" folder
# the current repo lives in, e.g. ~/Workplace/Spartan/loanbud-hq, so a single
# agent can work across all of its repos.
#
#   claude-org.sh <pane-path> [origin-window-id]
#
# The org folder is the parent of the repo's git root. Outside a git repo the
# pane path itself is used, so pressing the key in the org folder also works.

path="${1:-$PWD}"
window="${2:-}"

root="$(git -C "$path" rev-parse --show-toplevel 2>/dev/null)"
if [ -n "$root" ]; then
  org="$(dirname "$root")"
else
  org="$path"
fi

exec "$HOME/.tmux/plugins/tmux-claude-hatch/scripts/launch.sh" "$org" "$window"
