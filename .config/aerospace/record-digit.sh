#!/bin/bash
# Record the digit of the focused workspace under its letter, so that
# goto-space.sh / move-to-space.sh can restore the last-visited digit
# when switching letters. State lives in $TMPDIR so it clears on reboot.
#
# Usage: record-digit.sh <workspace-name>   (e.g. A3)

WS="$1"
[ -z "$WS" ] && exit 0

LETTER="${WS:0:1}"
DIGIT="${WS:1}"

STATE_DIR="${TMPDIR:-/tmp}"
STATE_DIR="${STATE_DIR%/}/aerospace-last-digit"
mkdir -p "$STATE_DIR"
printf '%s' "$DIGIT" > "$STATE_DIR/$LETTER"
