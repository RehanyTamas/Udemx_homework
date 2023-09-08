#!/bin/bash

DATE=$(date '+%Y-%m-%d')

SOURCE_DIR="/var/log"
OUTPUT_FILE="/opt/scripts/$DATE/mod-$DATE.out"

cd "$SOURCE_DIR" || exit 1

# List the last three modified files and save to the output file
sudo bash -c 'find "$SOURCE_DIR" -type f -printf "%T@ %p\n" | sort -n | tail -3 | awk "{print $2}" > "$OUTPUT_FILE"'
