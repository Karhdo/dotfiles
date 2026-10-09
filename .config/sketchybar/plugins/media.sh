#!/usr/bin/env bash
# media_change: "Title - Artist" while something plays, hidden otherwise.
[ "$SENDER" = media_change ] || exit 0

if [ "$(jq -r '.state' <<<"$INFO")" = playing ]; then
  title=$(jq -r '.title' <<<"$INFO")
  artist=$(jq -r '.artist' <<<"$INFO")
  sketchybar --set "$NAME" drawing=on label="$title${artist:+ - $artist}"
else
  sketchybar --set "$NAME" drawing=off
fi
