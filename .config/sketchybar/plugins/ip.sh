#!/bin/bash

source "$HOME/.config/colors.sh"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
  COLOR=$COLOR_CYAN
  ICON=󰦝
  LABEL="VPN"
elif [[ $IP_ADDRESS != "" ]]; then
  COLOR=$COLOR_BLUE
  ICON=󰖩
  LABEL=$IP_ADDRESS
else
  COLOR=$COLOR_WHITE
  ICON=󰖪
  LABEL="Not Connected"
fi

sketchybar --set $NAME \
  icon.color=$COLOR \
  label.color=$COLOR \
  icon=$ICON \
  label="$LABEL"
