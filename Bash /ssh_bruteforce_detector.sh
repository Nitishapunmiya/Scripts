  GNU nano 6.2                                                     ssh_bruteforce_detector.sh
#!/bin/bash

echo "====== SSH Security Monitor ======"

echo

echo "Failed Attempts:"
grep 'Failed password' /var/log/auth.log | wc -l

echo

echo "Top attacking IP:"
grep 'Failed password' /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | head -n 1

echo

echo "Attempts:"
attempts=$(grep 'Failed password' /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1}')

echo "$attempts"

echo

if [ "$attempts" -lt 5 ]
then
    echo "STATUS: NORMAL"

elif [ "$attempts" -le 10 ]
then
    echo "STATUS: WARNING"

else
    echo "STATUS: POSSIBLE BRUTE FORCE"
fi
