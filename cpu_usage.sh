#!/bin/bash

# 1. Get the idle percentage specifically by looking for 'id'
# This handles the decimal point correctly for Ubuntu
IDLE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")

# 2. Calculate usage (100 - idle)
# We use 'printf' to ensure we handle the floating point correctly
USAGE=$(echo "100 - $IDLE" | bc)

echo "Current CPU Usage: $USAGE%"

# 3. Compare with Threshold (e.g., 80)
THRESHOLD=80

if [ $(echo "$USAGE > $THRESHOLD" | bc) -ne 0 ]; then
    echo "⚠️ WARNING: CPU usage is high ($USAGE%)!"
else
    echo "✅ CPU usage is within normal limits."
fi
