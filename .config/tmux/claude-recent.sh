#!/usr/bin/env bash
# prefix+r: reopen the Claude popup used last, on the window it was left on.
# prefix+F: same, full size; inside an open popup it toggles full/normal size.
#
#   claude-recent.sh <origin-window-id> [--full]

set -uo pipefail
# shellcheck source=SCRIPTDIR/claude-lib.sh
. "$(dirname "$0")/claude-lib.sh"

origin="$1"
full="${2:-}"

client_width() {
  tmux list-clients -F $'#{client_name}\t#{client_width}' | awk -F'\t' -v c="$1" '$1 == c { print $2 }'
}

# The terminal showing the popup: the client on the origin window's session,
# else the most recently active client outside the popup sessions.
terminal_client() {
  local session="$1" origin_session
  origin_session="$(tmux display-message -p -t "$(tmux show-options -qv -t "$session" @claude_origin)" \
    '#{session_id}' 2>/dev/null)"
  tmux list-clients -F $'#{client_activity}\t#{client_name}\t#{session_id}\t#{session_name}' | sort -rn |
    awk -F'\t' -v o="$origin_session" -v p="$CLAUDE_PREFIX" '
      $3 == o { print $2; found = 1; exit }
      index($4, p) != 1 && fallback == "" { fallback = $2 }
      END { if (!found && fallback != "") print fallback }'
}

toggle_full() {
  local session client popup terminal width=100% height=100%
  session="$(tmux display-message -p '#S')"
  client="$(terminal_client "$session")"
  if [ -z "$client" ]; then
    tmux display-message 'No terminal found for this popup'
    return
  fi

  # The rounded border takes two columns, so a full-size popup is 2 narrower.
  popup="$(client_width "$(tmux list-clients -t "$session" -F '#{client_name}' | head -1)")"
  terminal="$(client_width "$client")"
  if [ "$popup" -ge $((terminal - 2)) ]; then
    width="$POPUP_WIDTH"
    height="$POPUP_HEIGHT"
  fi

  tmux display-popup -C -c "$client"
  open_popup "$session" "$width" "$height" "$client"
}

reopen_last() {
  local session width="$POPUP_WIDTH" height="$POPUP_HEIGHT"
  session="$(tmux list-sessions -F $'#{session_last_attached}\t#{session_name}' |
    awk -F'\t' -v p="$CLAUDE_PREFIX" 'index($2, p) == 1' | sort -rn | head -1 | cut -f2)"
  if [ -z "$session" ]; then
    tmux display-message 'No Claude popup to reopen'
    return
  fi

  [ -n "$origin" ] && tmux set-option -t "$session" @claude_origin "$origin"
  if [ "$full" = --full ]; then
    width=100%
    height=100%
  fi
  open_popup "$session" "$width" "$height"
}

if ! in_popup; then
  reopen_last
elif [ "$full" = --full ]; then
  toggle_full
else
  refuse_in_popup
fi
