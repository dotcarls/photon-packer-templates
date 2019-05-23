#!/usr/bin/env bash

tdnf install --assumeyes bc

function zerofill {
   cat /dev/zero > $1/zero.fill
   sync
   sleep 1
   sync
   rm -f $1/zero.fill
}


echo "Compacting disk space"
FileSystem=`grep ext /etc/mtab| awk -F" " '{ print $2 }'`

for i in $FileSystem
do
    echo $i
    number=`df -B 512 $i | awk -F" " '{print $3}' | grep -v Used`
    echo $number
    percent=$(echo "scale=0; $number * 98 / 100" | bc )
    echo $percent
    zerofill $i
done

tdnf erase --assumeyes bc