#!/bin/bash

# Setting paths to files based on the specified directory
DIR="/path/to/your/directory"

# Setting paths to files based on the specified directory
TIME_LOG="${DIR}/time.log"
TRAINING_LOG="${DIR}/training.log"
MY_LOG="${DIR}/my.log"

# [1] Merging two files into my.log to consolidate data
paste -d ' ' ${TIME_LOG} ${TRAINING_LOG} > ${MY_LOG}

# [2] Showing only the events that are timestamped at 13:37 in the my.log file
grep -E '(^| )13:37($| )' ${MY_LOG}

# [4] Displaying only the columns "Mounted on" and "Use%" from the disk space information, extracted from command
df -h /home | awk 'NR==2 {print $6, $5}'

# [6] Counting occurrences of the word "Pharetra" in my.log, ignoring case sensitivity
grep -i -c 'Pharetra' ${MY_LOG}

# [10] Counting the number of words that contain the preposition "in" from the lines filtered in [9]
grep -n 'Tristique' my.log | head -n 3 | tac | grep -wc 'in'

# [12] Displaying three lines before and four lines after the lines where the sentences "Ultricies mi eget mauris pharetra et. Ut eu sem integer vitae." are found in my.log from [11]
grep -B 3 -A 4 -n "Ultricies mi eget mauris pharetra et. Ut eu sem integer vitae." ${MY_LOG}

# [13] Retrieving the first eight lines of my.log and displaying only the 7th and 8th lines
head -n 8 ${MY_LOG} | tail -n 2