#!/bin/bash

ips=$(grep '404'  access.log |awk '{print $1}' | sort | uniq -c | sort -nr)

while read -r line

do

        count=$(echo "$line" | awk  '{print $1}')
        ip=$(echo "$line" | awk '{print $2}')

        echo "$ip -> $count 404 requets"

        if [ "$count" -gt 10 ]
        then
        echo "Possible brute force attack"
        elif  [ "$count" -ge 5 ]
    then
        echo "⚠️ WARNING"
    else
        echo "STATUS: NORMAL"
    fi

    echo

done <<< "$ips"
