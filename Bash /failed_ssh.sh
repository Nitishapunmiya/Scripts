#!/bin/bash

while read line
do
    if [[ "$line" == *"Failed password"* ]]; then
        echo "$line"
    fi
done < /var/log/auth.log
