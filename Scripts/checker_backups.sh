# a script to create backups of a directory and keep only the last 5 backups.

#!/bin/bash

max_backups=5

tar -cvf /home/adminvm/new_tasks/backups/backups_$(date +'%Y-%m-%d_%H-%M-%S').tar /home/adminvm/new_tasks/*.sh

num_backups=$(ls -t1 backups | wc -l)

if [[ $num_backups -gt $max_backups ]]; then
        rm "backups/$(ls -t1 backups | tail -n 1)"
fi