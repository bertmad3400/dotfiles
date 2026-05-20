#!/bin/bash
# For highlighting selected workspace

sketchybar --set space.$FOCUSED_WORKSPACE label.drawing=off icon.drawing=on background.drawing=on
sketchybar --set space.$PREV_WORKSPACE label.drawing=on icon.drawing=off background.drawing=off
