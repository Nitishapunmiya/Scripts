  GNU nano 6.2                                                            largefile.sh
#!/bin/bash

echo "enter file name here : "

read  logfile

if [ ! -f  "$logfile" ]

then
        echo "NO SUCH FILE "

        exit 1

fi



while read -r line
do
        ip=$(echo "$line" | awk '{print $1}')
        file=$(echo "$line" | awk  '{print $7}')
        size=$(echo "$line" | awk '{print $NF}')

        if [ "$size" -gt 500000 ]
        then

        echo "----large Download detected----"
        echo  "IP : $ip "
        echo "FILENAME : $file"
        echo "SIZE : $size bytes"
fi
done < "$logfile"
