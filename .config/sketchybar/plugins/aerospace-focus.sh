#!/bin/bash
# Fires on aerospace_workspace_change.
# Inputs (set by aerospace via exec-on-workspace-change):
#   FOCUSED_WORKSPACE, PREV_WORKSPACE   (e.g. "A3", "B7")
#
# 10 shared digit items (space.0..space.9) are retargeted to the active letter
# instead of toggling drawing on 50 items — avoids relayout flicker.

PLUGIN_DIR="$(dirname "$0")"

CURR_LETTER="${FOCUSED_WORKSPACE:0:1}"
CURR_DIGIT="${FOCUSED_WORKSPACE:1:1}"
PREV_LETTER="${PREV_WORKSPACE:0:1}"
PREV_DIGIT="${PREV_WORKSPACE:1:1}"

if [[ "$CURR_LETTER" == "$PREV_LETTER" ]]; then
    # Same letter — just move the focused badge between two digit items.
    sketchybar --set "space.$CURR_DIGIT" label.drawing=off icon.drawing=on  background.drawing=on \
               --set "space.$PREV_DIGIT" label.drawing=on  icon.drawing=off background.drawing=off
    exit 0
fi

# Letter changed — rewire all 10 digit items in a single batched call.
WS_LIST=$(aerospace list-workspaces --all --format "%{workspace},%{monitor-id}")
USED=$(aerospace list-windows --all --format '%{workspace}' | sort -u)

args=()
for d in 0 1 2 3 4 5 6 7 8 9; do
    ws="${CURR_LETTER}${d}"
    display=$(printf '%s\n' "$WS_LIST" | grep "^${ws}," | cut -d, -f2)
    if printf '%s\n' "$USED" | grep -qx "$ws"; then
        label_color=0xffffffff
    else
        label_color=0x77ffffff
    fi
    if [[ "$d" == "$CURR_DIGIT" ]]; then
        args+=(--set "space.$d"
            display="$display"
            click_script="$PLUGIN_DIR/aerospace-goto.sh $ws"
            label.color="$label_color"
            label.drawing=off icon.drawing=on background.drawing=on)
    else
        args+=(--set "space.$d"
            display="$display"
            click_script="$PLUGIN_DIR/aerospace-goto.sh $ws"
            label.color="$label_color"
            label.drawing=on icon.drawing=off background.drawing=off)
    fi
done

# Show only the active space-letter indicator
for L in A B C D E; do
    if [[ "$L" == "$CURR_LETTER" ]]; then
        args+=(--set "spaceletter.$L" drawing=on)
    else
        args+=(--set "spaceletter.$L" drawing=off)
    fi
done

sketchybar "${args[@]}"
