#!/bin/bash

THRESHOLD=80

CPU_IDLE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)

echo "Current CPU Usage: $CPU_USAGE%"

if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "⚠️ WARNING: CPU usage is high ($CPU_USAGE%)!"
else
    echo "✅ CPU usage is within normal limits."
fi
