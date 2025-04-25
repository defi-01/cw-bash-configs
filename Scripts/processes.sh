#  Increase the value of CPU Load Average above 80%

#!/bin/bash

if ! command -v stress &> /dev/null; then
    sudo apt-get update
    sudo apt-get install stress -y
fi

stress --cpu 4 --timeout 60s

load_average=$(awk '{print $1}' /proc/loadavg)
echo "CPU Load Average: $load_average"

if (( $(echo "$load_average > 0.7" | bc -l) )); then
    echo "Passed"
else
    echo "Failed"
    exit 1
fi
