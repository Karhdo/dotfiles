#!/usr/bin/env bash
# prefix+y: open Claude for the current dir in the tmux session's popup.
#
#   claude-popup.sh <session-path> <pane-path> <origin-window-id>
#
# Each tmux session gets one popup session, keyed by its start dir (e.g. the
# LoanBud session -> loanbud-hq), with a window per dir tagged @claude_dir.
# Pressing the key again in a dir reopens that dir's window.

set -uo pipefail
# shellcheck source=SCRIPTDIR/claude-lib.sh
. "$(dirname "$0")/claude-lib.sh"

group="$1"
dir="$2"
origin="$3"

if in_popup; then
  refuse_in_popup
  exit 0
fi

session="${CLAUDE_PREFIX}$(session_hash "$group")"
cmd="$(get_tmux_option @claude_command 'claude')"
args="$(get_tmux_option @claude_args '')"
cmd="$cmd${args:+ $args}"
name="$(basename "$dir")"

if tmux has-session -t "=$session" 2>/dev/null; then
  target="$(tmux list-windows -t "=$session" -F $'#{window_id}\t#{@claude_dir}' |
    awk -F'\t' -v d="$dir" '$2 == d { print $1; exit }')"
  [ -n "$target" ] ||
    target="$(tmux new-window -d -P -F '#{window_id}' -t "=$session:" -n "$name" -c "$dir" "$cmd")"
else
  target="$(tmux new-session -d -P -F '#{window_id}' -s "$session" -n "$name" -c "$dir" "$cmd")"
fi
tmux set-option -w -t "$target" @claude_dir "$dir"
tmux select-window -t "$target"

# Same bookkeeping as the plugin's launch.sh: close the popup when the session
# ends, and remember the launching window for the picker's jump back.
tmux set-option -t "$session" detach-on-destroy on
[ -n "$origin" ] && tmux set-option -t "$session" @claude_origin "$origin"
tmux set-option -t "$session" @claude_title " Agents · $(basename "$group") "

open_popup "$session" "$POPUP_WIDTH" "$POPUP_HEIGHT"
