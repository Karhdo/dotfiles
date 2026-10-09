#!/usr/bin/env bash
# Battery level (icon by charge, charging icon on AC power).
batt=$(pmset -g batt)
percent=$(grep -Eo '[0-9]+%' <<<"$batt" | tr -d %)
[ -n "$percent" ] || exit 0

case "$percent" in
  9[0-9] | 100) icon=󰁹 ;;
  [6-8][0-9]) icon=󰂀 ;;
  [3-5][0-9]) icon=󰁾 ;;
  [1-2][0-9]) icon=󰁼 ;;
  *) icon=󰁺 ;;
esac
grep -q 'AC Power' <<<"$batt" && icon=󰂄

sketchybar --set "$NAME" icon="$icon" label="$percent%"
