#!/usr/bin/env bash
# Total CPU across all cores, as a percentage of the whole machine.
cores=$(sysctl -n hw.ncpu)
usage=$(ps -A -o %cpu= | awk -v n="$cores" '{ s += $1 } END { printf "%d", s / n }')
sketchybar --set "$NAME" label="$usage%"
