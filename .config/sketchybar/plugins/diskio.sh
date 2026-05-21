#!/bin/bash

# Stream per-second disk read/write throughput by polling IOKit's
# "Bytes (Read)" / "Bytes (Write)" counters from every IOBlockStorageDriver,
# summing across disks, and pushing the 1-second delta to sketchybar.
# (macOS `top`/`iostat` don't expose byte-precision split read/write.)

human() {
  local b=$1
  if   [ "$b" -lt 1024 ]; then        echo "0 KB"
  elif [ "$b" -lt 1048576 ]; then     echo "$((b / 1024)) KB"
  elif [ "$b" -lt 1073741824 ]; then  echo "$((b / 1048576)) MB"
  else awk -v n="$b" 'BEGIN { printf "%.1f GB", n / 1073741824 }'
  fi
}

read_counters() {
  local io
  io=$(ioreg -c IOBlockStorageDriver -r)
  R=$(printf '%s' "$io" | grep -oE '"Bytes \(Read\)"=[0-9]+'  | awk -F= '{s+=$2} END {print s+0}')
  W=$(printf '%s' "$io" | grep -oE '"Bytes \(Write\)"=[0-9]+' | awk -F= '{s+=$2} END {print s+0}')
}

if [ "$1" = "--loop" ]; then
  read_counters; prev_r=$R; prev_w=$W
  while sleep 1; do
    read_counters
    dr=$((R - prev_r)); [ $dr -lt 0 ] && dr=0
    dw=$((W - prev_w)); [ $dw -lt 0 ] && dw=0
    prev_r=$R; prev_w=$W
    sketchybar --set diskio_read  label="$(human $dr)"
    sketchybar --set diskio_write label="$(human $dw)"
  done
  exit 0
fi

# Kill any previous loop, then start a fresh one.
pkill -f "diskio.sh --loop" 2>/dev/null
"$0" --loop &
