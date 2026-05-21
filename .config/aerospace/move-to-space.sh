#!/bin/bash
# Move focused window to another "space" (A..E), targeting the last digit
# visited in that letter (defaulting to 0 if never visited this session).
# Does NOT follow the window — focus stays put.
#
# Usage: move-to-space.sh <letter>

LETTER="$1"

case "$LETTER" in
    A|B|C|D|E) ;;
    *) echo "letter must be A..E" >&2; exit 1 ;;
esac

STATE_DIR="${TMPDIR:-/tmp}"
STATE_DIR="${STATE_DIR%/}/aerospace-last-digit"
DIGIT=$(cat "$STATE_DIR/$LETTER" 2>/dev/null)
[ -z "$DIGIT" ] && DIGIT=0

aerospace move-node-to-workspace "${LETTER}${DIGIT}"
