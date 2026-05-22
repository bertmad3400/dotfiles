#!/bin/bash
# Differentiate workspaces with windows (bright label) from empty ones (dim).
# With 10 shared digit items, only the current letter's workspaces are queried.

FOCUSED=$(aerospace list-workspaces --focused)
LETTER="${FOCUSED:0:1}"
USED=$(aerospace list-windows --all --format '%{workspace}' | sort -u)

args=()
for d in 0 1 2 3 4 5 6 7 8 9; do
    ws="${LETTER}${d}"
    if printf '%s\n' "$USED" | grep -qx "$ws"; then
        args+=(--set "space.$d" label.color=0xffffffff)
    else
        args+=(--set "space.$d" label.color=0x77ffffff)
    fi
done
sketchybar "${args[@]}"
