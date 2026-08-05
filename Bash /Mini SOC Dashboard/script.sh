#! /bin/bash

echo "====== SOC DASHBOARD ======"

echo "Date : $(date)"

echo

echo "Hostname : $(hostname)"

echo

echo "Failed ssh attemps : $(grep 'Failed password'  /var/log/auth.log)"

echo

echo "Succesfull login attemps : $(grep 'Accepted password'  /var/log/.auth.log)"

echo

echo "Disk Usage : $(df -h / | awk 'NR==2 {print $5}')"

echo

echo "Memory Usage : $(free -h | awk '/Mem:/ {print $3}')"

echo

echo  "Available Memory: $(free -h | awk '/Mem:/ {print $7}')"

echo

echo "Top 5 memory process $(ps -eo pid,user,comm,%mem --sort=-%mem | head -n 6)"

echo

echo "-------------END OF REPORT-----------------"


