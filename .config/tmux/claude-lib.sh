# shellcheck shell=bash
# Shared by the claude-*.sh popup scripts; sourced, not run.

# shellcheck source=/dev/null
. "$HOME/.tmux/plugins/tmux-claude-hatch/scripts/helpers.sh"

CLAUDE_PREFIX="$(get_tmux_option @claude_session_prefix 'claude-')"
POPUP_WIDTH="$(get_tmux_option @claude_popup_width '90%')"
POPUP_HEIGHT="$(get_tmux_option @claude_popup_height '90%')"

# A key pressed inside a popup runs on the popup's own client, which sits on a
# Claude session rather than on the terminal's session.
in_popup() {
  [[ "$(tmux display-message -p '#S')" == "$CLAUDE_PREFIX"* ]]
}

refuse_in_popup() {
  tmux display-message '🫪 Popup window already open'
}

# open_popup <session> <width> <height> [client]
open_popup() {
  local session="$1" width="$2" height="$3" client="${4:-}" title
  title="$(tmux show-options -qv -t "$session" @claude_title)"
  set -- -w "$width" -h "$height" -b rounded -T "${title:- Agent }" -E "tmux attach-session -t '$session'"
  if [ -n "$client" ]; then
    tmux display-popup -c "$client" "$@"
  else
    tmux display-popup "$@"
  fi
}
