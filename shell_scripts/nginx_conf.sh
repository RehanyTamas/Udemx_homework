#!/bin/bash

CONTAINER_NAME="nginx_server"

# Exec into container and modify the file
sudo docker exec -it "$CONTAINER_NAME" /bin/bash -c "sed -i 's/<title>Welcome to nginx!<\\/title>/Title:Welcome to nginx!<\\/title>/g' /usr/share/nginx/html/index.html"

