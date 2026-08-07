#print users who have successfully logged in
#!/bin/bash

# Successful SSH login detector

log="/var/log/auth.log"

echo "===== Successful SSH Login Report ====="

grep "Accepted password" "$log" | \
awk '{print $1, $2, $3, "User:", $(NF-5), "IP:", $(NF-3)}'
