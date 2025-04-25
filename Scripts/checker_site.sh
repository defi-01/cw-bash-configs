# monitor website availability and log status

#!/bin/bash

website="https://google.com"

log_file="/home/adminvm/new_tasks/log.log"

response=$(curl -Is "$website" | head -n 1)

if [[ "$response" =~ "200 OK" ]]; then
        echo "$(date +"%Y-%m-%d %T"): website $website is up" >> "$log_file"
    else
        echo "$(date +"%Y-%m-%d %T"): website $website is down" >> "$log_file"
fi 
