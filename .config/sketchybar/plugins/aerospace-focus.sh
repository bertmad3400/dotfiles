#!/bin/bash
# Fires on aerospace_workspace_change.
# Inputs (set by aerospace via exec-on-workspace-change):
#   FOCUSED_WORKSPACE, PREV_WORKSPACE   (e.g. "A3", "B7")

CURR_LETTER="${FOCUSED_WORKSPACE:0:1}"
PREV_LETTER="${PREV_WORKSPACE:0:1}"

# Focused-workspace badge: show black-on-white icon instead of plain label
sketchybar --set "space.$FOCUSED_WORKSPACE" label.drawing=off icon.drawing=on background.drawing=on
sketchybar --set "space.$PREV_WORKSPACE"    label.drawing=on  icon.drawing=off background.drawing=off

# If the active space (letter) changed, swap which 10 workspaces are visible
if [[ "$CURR_LETTER" != "$PREV_LETTER" ]]; then
    for d in 0 1 2 3 4 5 6 7 8 9; do
        sketchybar --set "space.${PREV_LETTER}${d}" drawing=off
        sketchybar --set "space.${CURR_LETTER}${d}" drawing=on
    done

    # Show only the active space-letter indicator
    for L in A B C D E; do
        if [[ "$L" == "$CURR_LETTER" ]]; then
            sketchybar --set "spaceletter.$L" drawing=on
        else
            sketchybar --set "spaceletter.$L" drawing=off
        fi
    done
fi
