#!/bin/bash

read -p "Enter log file path: " logfile

if [ ! -f "$logfile" ]
then
    echo "File does not exist."
    exit 1
fi

echo
echo "Unique IP Addresses:"
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$logfile" | sort | uniq
