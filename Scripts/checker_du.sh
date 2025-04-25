# A script to check disk space usage and send an email alert if it's below a certain threshold.
#!/bin/bash

mail="test@gmail.com"
threshold=90
disk_usage=$(df -h | awk 'NR > 1 gsub("%", "") {print $5}')

for i in $disk_usage; do
        if [[ $i -ge $threshold ]]; then
                echo "ACHTUNG!!!" | mail -s "disk space usage is below threshold. Current usage: $i%" $mail
        fi
done
