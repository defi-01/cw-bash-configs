#!/bin/bash

# [1]
echo 'Checking top 20 most accessed URLs on this server with the number of requests they receive'
grep -oP '"[A-Z]+\s\K\/[^ "]+' access.log | sed 's/\?.*//' | sort | uniq -c | sort -nr | head -n 20
echo "============================================================================================="

# [2]
echo 'Checking top 20 most active IP addresses with the number of requests they generate'
grep -oP '^[^ ]+' access.log | sort | uniq -c | sort -nr | head -n 20
echo "=================================================================================="

# [3]
echo 'Checking top 5 most popular User Agents from the logs and number of visitors with these User Agents'
grep -oP '"[^"]*"$' access.log | sort | uniq -c | sort -nr | head -n 5
echo "==================================================================================================="

# [4]
echo 'Checking total number of requests during the period of 12:00:00-12:59:59'
grep -Ec '\[25/Nov/2020:12:[0-5][0-9]:[0-9]{2} ' access.log
echo "========================================================================"

# [5]
echo 'Checking total number of successful responses (HTTP response code 200)'
grep -c 'HTTP/[0-9.]*" 200 ' access.log
echo "======================================================================"

# [6]
echo 'Checking total number of requests to pages that were not found on the site'
