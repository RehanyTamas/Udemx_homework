#!/bin/bash

# Define the container name and database information
CONTAINER_NAME="mariaDB"
DB_USER="udemx"
DB_PASSWORD="udemx_password"
DB_NAME="udemx-db"
DATE=$(date '+%Y-%m-%d')
BACKUP_DIR="/opt/scripts/$DATE"

BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Use mysqldump to create the database dump
sudo bash -c 'docker exec -i "$CONTAINER_NAME" mysqldump -u "$DB_USER" -p "$DB_PASSWORD" "$DB_NAME" > "$BACKUP_FILE"'

# Copy the dump file from the container to the host
docker cp "$CONTAINER_NAME:$BACKUP_FILE" "$BACKUP_DIR"

