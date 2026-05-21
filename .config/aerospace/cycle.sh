#!/bin/bash
# Cycle within the current "space" (A..E). Sequence: 1,2,3,4,5,6,7,8,9,0.
# Wraps both ways. Stays within the current space — never crosses letters.
#
# Usage: cycle.sh focus|move next|prev

ACTION="$1"
DIR="$2"

CURR=$(aerospace list-workspaces --focused)
LETTER="${CURR:0:1}"
DIGIT="${CURR:1}"

# Map digit -> position in the 1..9,0 sequence: 1->0, 2->1, ..., 9->8, 0->9
IDX=$(( (DIGIT + 9) % 10 ))
case "$DIR" in
    next) IDX=$(( (IDX + 1) % 10 )) ;;
    prev) IDX=$(( (IDX + 9) % 10 )) ;;
    *)    echo "direction: next|prev" >&2; exit 1 ;;
esac
NEW=$(( (IDX + 1) % 10 ))
TARGET="${LETTER}${NEW}"

case "$ACTION" in
    focus) aerospace workspace "$TARGET" ;;
    move)  aerospace move-node-to-workspace --focus-follows-window "$TARGET" ;;
    *)     echo "action: focus|move" >&2; exit 1 ;;
esac
