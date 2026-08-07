#this script is to detect failed ssh login attemps .
#it extracts the ip and print the number of times ip is attemting to performe brute force



#!/bin/bash

echo "====Failed SSH logins===="

grep  'Failed password'  /var/log/auth.log | \
awk '{print  $(NF-3)}' | \
sort | uniq -c | sort -nr | \
awk '{printf "%-15s : %s attempts\n", $2, $1}'
