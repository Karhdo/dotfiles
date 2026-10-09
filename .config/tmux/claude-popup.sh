#!/usr/bin/env bash
# Open Claude for the current directory inside one shared tmux-claude-hatch
# popup session per outer tmux session (keyed by that session's start dir, e.g.
# the LoanBud session -> loanbud-hq). Each directory gets its own window, named
# after it; pressing the key again in that directory reopens its window.
#
#   claude-popup.sh <session-path> <pane-path> <origin-window-id> [claude args...]
#
# Extra args (e.g. --resume) apply only when a new Claude window is created.

HATCH="$HOME/.tmux/plugins/tmux-claude-hatch/scripts"
# shellcheck source=/dev/null
. "$HATCH/helpers.sh"

group="$1"
dir="$2"
window="$3"
shift 3

prefix="$(get_tmux_option @claude_session_prefix 'claude-')"
cmd="$(get_tmux_option @claude_command 'claude')"
args="$(get_tmux_option @claude_args '')"
[ -n "$args" ] && cmd="$cmd $args"
[ $# -gt 0 ] && cmd="$cmd $*"
w="$(get_tmux_option @claude_popup_width '90%')"
h="$(get_tmux_option @claude_popup_height '90%')"

session="${prefix}$(session_hash "$group")"

if [[ "$(tmux display-message -p '#S')" == "$prefix"* ]]; then
  tmux display-message '🫪 Popup window already open'
  exit 0
fi

if tmux has-session -t "=$session" 2>/dev/null; then
  target="$(tmux list-windows -t "=$session" -F $'#{window_id}\t#{@claude_dir}' |
    awk -F'\t' -v d="$dir" '$2 == d { print $1; exit }')"
  [ -n "$target" ] ||
    target="$(tmux new-window -d -P -F '#{window_id}' -t "=$session:" \
      -n "$(basename "$dir")" -c "$dir" "$cmd")"
else
  target="$(tmux new-session -d -P -F '#{window_id}' -s "$session" \
    -n "$(basename "$dir")" -c "$dir" "$cmd")"
fi
tmux set-option -w -t "$target" @claude_dir "$dir"
tmux select-window -t "$target"

# Same bookkeeping as the plugin's launch.sh: close the popup when the session
# ends, and remember the launching window for the picker's jump.
tmux set-option -t "$session" detach-on-destroy on
[ -n "$window" ] && tmux set-option -t "$session" @claude_origin "$window"

title=" Agents · $(basename "$group") "
tmux display-popup -w "$w" -h "$h" -b rounded -T "$title" -E "tmux attach-session -t '$session'"
