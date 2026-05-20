#!/bin/bash

# Function to convert bytes to a human-readable format
human_readable() {
  local bytes=$1
  if [ "$bytes" -lt 1024 ]; then
    echo "0 KB"
  elif [ "$bytes" -lt 1048576 ]; then
    echo "$((bytes / 1024)) KB"
  elif [ "$bytes" -lt 1073741824 ]; then
    echo "$((bytes / 1048576)) MB"
  else
    echo "$((bytes / 1073741824)) GB"
  fi
}

pkill -f "netstat -w1"

# Use netstat with the -w flag to monitor network traffic continuously
netstat -w 1 | awk '/[0-9]/ {print $3 "," $6; fflush(stdout)}' | while read -r total_bytes; do
  # Convert to human-readable format
  incomming=$(human_readable "$(echo $total_bytes | cut -d, -f1)")
  outgoing=$(human_readable "$(echo $total_bytes | cut -d, -f2)")

  sketchybar --set network_up label="$outgoing"
  sketchybar --set network_down label="$incomming"
done &
