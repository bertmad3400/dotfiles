#!/bin/sh

PERCENT=$(vm_stat | awk '
  /page size of/        { page = $8 + 0 }
  /Pages active/        { active = $3 + 0 }
  /Pages wired down/    { wired = $4 + 0 }
  /Pages occupied by compressor/ { comp = $5 + 0 }
  /Pages free/          { free = $3 + 0 }
  /Pages inactive/      { inactive = $3 + 0 }
  /Pages speculative/   { spec = $3 + 0 }
  /Pages purgeable/     { purge = $3 + 0 }
  END {
    used  = active + wired + comp - purge
    total = active + wired + comp + free + inactive + spec
    if (total > 0) printf("%.0f", used * 100 / total)
  }')

sketchybar --set "$NAME" label="${PERCENT}%"
