# The script records packet loss percentage data from pinging "cisco.com" along with the current date and time to a file named "result_ping.txt".

#!/bin/bash

ping_result=$(ping -c 17 cisco.com)
packet_loss=$(echo "$ping_result" | grep -o '[0-9.]*% packet loss' | awk '{print $1}')
current_date=$(date +'%Y-%m-%d %H:%M:%S')

echo "$current_date -- site loss percentage: $packet_loss" >> /home/adminvm/result_ping.txt
