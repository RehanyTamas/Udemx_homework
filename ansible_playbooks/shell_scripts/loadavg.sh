#!/bin/bash

DATE=$(date '+%Y-%m-%d')

SOURCE="/proc/loadavg"
OUTPUT_FILE="/opt/scripts/$DATE/last_five-$DATE.out"

# Extract the 15-minute load average from /proc/loadavg
LOAD_AVG_15MIN=$(awk '{print $3}' $SOURCE)

# Write the 15-minute load average to the output file
sudo bash -c 'echo "$LOAD_AVG_15MIN" > "$OUTPUT_FILE"'

