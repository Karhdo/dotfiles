#!/usr/bin/env bash
# front_app_switched: show the focused app's icon and name.
[ "$SENDER" = front_app_switched ] || exit 0
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

__icon_map "$INFO"
sketchybar --set "$NAME" icon="$icon_result" label="$INFO"
