#!/usr/bin/env bash
# space_windows_change: redraw the app icons of the space that changed.
[ "$SENDER" = space_windows_change ] || exit 0
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

space=$(jq -r '.space' <<<"$INFO")
apps=$(jq -r '.apps | keys[]' <<<"$INFO")

icons=""
while read -r app; do
  [ -n "$app" ] || continue
  __icon_map "$app"
  icons+="$icon_result "
done <<<"$apps"

sketchybar --set "space.$space" label="${icons:-—}"
