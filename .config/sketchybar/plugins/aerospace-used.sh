#!/bin/bash
# For differentiating between workspaces with and without windows (in or not in use)

USED_SPACES=$(aerospace list-windows --all --format '%{workspace}' | sort | uniq)

sketchybar --set "/space\.[^$(echo $USED_SPACES | tr -d '\n')]/" label.color="0x77ffffff"

for sid in $USED_SPACES; do
  sketchybar --set "space.$sid" label.color="0xffffffff"
done
