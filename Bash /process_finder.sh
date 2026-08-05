#!/bin/bash

read -p "Enter process name: " process

pid=$(pgrep "$process")

if [ -n "$pid" ]
then
    echo "Process is running."
    echo "PID: $pid"
else
    echo "Process not running."
fi
