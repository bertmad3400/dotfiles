#!/bin/bash

source "$HOME/.config/colors.sh"

ICONS_VOLUME=(󰸈 󰕿 󰖀 󰕾)

VOLUME=$INFO

case $VOLUME in
[6-9][0-9] | 100)
  ICON=${ICONS_VOLUME[3]}
  COLOR=$COLOR_RED
  ;;
[3-5][0-9])
  ICON=${ICONS_VOLUME[2]}
  COLOR=$COLOR_YELLOW
  ;;
[1-9] | [1-2][0-9])
  ICON=${ICONS_VOLUME[1]}
  COLOR=$COLOR_GREEN
  ;;
*)
  ICON=${ICONS_VOLUME[0]}
  COLOR=$COLOR_GREEN
  ;;
esac

sketchybar --set $NAME icon="$ICON" \
  icon.color=$COLOR \
  label="$VOLUME%" \
  label.color=$COLOR
