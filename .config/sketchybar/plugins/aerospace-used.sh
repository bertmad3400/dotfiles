#!/bin/bash
# Differentiate workspaces with windows (bright label) from empty ones (dim).
# Multi-char workspace names (A0..E9) — must iterate, not use char-class regex.

USED=$(aerospace list-windows --all --format '%{workspace}' | sort -u)
ALL=$(aerospace list-workspaces --all)

for WS in $ALL; do
    if printf '%s\n' "$USED" | grep -qx "$WS"; then
        sketchybar --set "space.$WS" label.color=0xffffffff
    else
        sketchybar --set "space.$WS" label.color=0x77ffffff
    fi
done
