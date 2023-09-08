#!/bin/bash

DATE=$(date '+%Y-%m-%d')

SOURCE_DIR="/var/log"
OUTPUT_FILE="/opt/scripts/$DATE/last_five-$DATE.out"


# Search for files modified in the last 5 days recursively and save to the output file
sudo bash -c "find $SOURCE_DIR -type f -mtime -5 -printf '%T@ %p\n' > $OUTPUT_FILE"

