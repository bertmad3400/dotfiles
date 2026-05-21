#!/bin/bash
# Switch AeroSpace mode + workspace in one shot.
# Used by sketchybar click handlers so the active mode tracks the active space.
#
# Usage: aerospace-goto.sh <workspace>   e.g. aerospace-goto.sh A3
#        aerospace-goto.sh <space-letter><digit>

WS="$1"
LETTER="${WS:0:1}"

case "$LETTER" in
    A) MODE="main" ;;
    B) MODE="space-b" ;;
    C) MODE="space-c" ;;
    D) MODE="space-d" ;;
    E) MODE="space-e" ;;
    *) echo "unknown space letter: $LETTER" >&2; exit 1 ;;
esac

aerospace mode "$MODE"
aerospace workspace "$WS"
