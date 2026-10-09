#!/usr/bin/env bash
# Only the space shown on its display gets a filled pill; the others are plain.
source "$HOME/.config/sketchybar/colors.sh"

if [ "$SELECTED" = true ]; then
  sketchybar --set "$NAME" background.drawing=on icon.color=$ACCENT_FG label.color=$ACCENT_FG
else
  sketchybar --set "$NAME" background.drawing=off icon.color=$FG label.color=$FG
fi
