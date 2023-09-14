#!/bin/bash

# List the shell scripts you want to execute
scripts=("dir_from_date.sh" "sql_dump.sh" "mod.sh" "mod.sh" "last_five.sh" "loadavg.sh" "nginx_conf.sh")

# Loop through the scripts and execute each one
for script in "${scripts[@]}"; do
  bash "/vagrant/shell_scripts/$script"
done

