  GNU nano 6.2                                                      file_permission_check.sh
#!/bin/bash

echo "enter your filename here : "

read file

if [ -f "$file" ] ; then
        echo "checking file permissions...."
        sleep 2

        if [ -r "$file" ] ; then
                echo "file is readable"
fi
        if [ -w "$file" ];then
                echo "file is writeable"
fi
        if [ -x  "$file" ] ; then
                echo  "file is executable"
fi
else
        echo "file doesnt exists"
fi
