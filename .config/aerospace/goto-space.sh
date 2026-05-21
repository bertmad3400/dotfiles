#!/bin/bash
# Switch to another "space" (A..E), restoring the last digit visited in that
# letter (defaulting to 1 if never visited this session).
# Also switches binding mode so digit keys keep matching the active space.
#
# Usage: goto-space.sh <letter>

LETTER="$1"

case "$LETTER" in
    A|B|C|D|E) ;;
    *) echo "letter must be A..E" >&2; exit 1 ;;
esac

STATE_DIR="${TMPDIR:-/tmp}"
STATE_DIR="${STATE_DIR%/}/aerospace-last-digit"
DIGIT=$(cat "$STATE_DIR/$LETTER" 2>/dev/null)
[ -z "$DIGIT" ] && DIGIT=1

# Mode is updated by exec-on-workspace-change (sync-mode.sh).
aerospace workspace "${LETTER}${DIGIT}"
