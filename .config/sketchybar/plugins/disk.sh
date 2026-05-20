#!/bin/sh

sketchybar --set "$NAME" label="$(df -H /System/Volumes/Data | awk 'NR==2 { print $5 }')"
