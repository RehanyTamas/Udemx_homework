#!/bin/bash

CONTAINER_NAME="nginx_server"

# Belépünk a konténerbe és módosítjuk a konfigurációs fájlt
sudo docker exec -it "$CONTAINER_NAME" /bin/bash -c "sed -i 's/<title>Welcome to nginx!<\\/title>/Title:Welcome to nginx!<\\/title>/g' /usr/share/nginx/html/index.html"

