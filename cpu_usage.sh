#!/bin/bash

# Define the threshold (e.g., 80%)
THRESHOLD=80

# Get the current CPU idle percentage and calculate usage
# We use 'top' in batch mode (-b) for a single iteration (-n 1)
CPU_IDLE=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $8}')
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)

echo "Current CPU Usage: $CPU_USAGE%"

# Check if usage exceeds the threshold
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "⚠️ WARNING: CPU usage is high ($CPU_USAGE%)!"
    # You could add an AWS CLI command here to alert you or stop the instance
else
    echo "✅ CPU usage is within normal limits."
fi
