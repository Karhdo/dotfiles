#!/usr/bin/env bash
# Reopen the Claude popup that was used last, on the window that was showing
# when it was hidden, wherever it was opened from (y/Y here, or the plugin's
# picker). tmux keeps each session's active window, so attaching is enough.
#
#   claude-recent.sh <origin-window-id>

HATCH="$HOME/.tmux/plugins/tmux-claude-hatch/scripts"
# shellcheck source=/dev/null
. "$HATCH/helpers.sh"

window="$1"
prefix="$(get_tmux_option @claude_session_prefix 'claude-')"
w="$(get_tmux_option @claude_popup_width '90%')"
h="$(get_tmux_option @claude_popup_height '90%')"

if [[ "$(tmux display-message -p '#S')" == "$prefix"* ]]; then
  tmux display-message '🫪 Popup window already open'
  exit 0
fi

session="$(tmux list-sessions -F $'#{session_last_attached}\t#{session_name}' |
  awk -F'\t' -v p="$prefix" 'index($2, p) == 1' | sort -rn | head -1 | cut -f2)"
if [ -z "$session" ]; then
  tmux display-message 'No Claude popup to reopen'
  exit 0
fi

[ -n "$window" ] && tmux set-option -t "$session" @claude_origin "$window"

title="$(tmux show-options -qv -t "$session" @claude_title)"
tmux display-popup -w "$w" -h "$h" -b rounded -T "${title:- Agent }" -E "tmux attach-session -t '$session'"
