#!/usr/bin/env bash
# Current keyboard input source: A (ABC) or VI (Vietnamese Telex).
if defaults read com.apple.HIToolbox AppleSelectedInputSources | grep -q Vietnamese; then
  label=VI
else
  label=A
fi
sketchybar --set "$NAME" label="$label"
