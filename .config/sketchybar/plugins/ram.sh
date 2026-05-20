#!/bin/sh

sketchybar --set $NAME label="$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%01.0f\n", 100-$5"%") }')%"
