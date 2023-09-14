#!/bin/bash

CONTAINER_NAME="mariaDB"
DB_USER="udemx"
DB_PASSWORD="udemx_password"
DB_NAME="udemx-db"
DATE=$(date '+%Y-%m-%d')
BACKUP_DIR="/opt/scripts/$DATE"

BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"

# Use mysqldump to create the database dump
sudo bash -c "docker exec -i $CONTAINER_NAME sh -c 'exec mariadb-dump -u $DB_USER -p$DB_PASSWORD $DB_NAME' > $BACKUP_FILE"


