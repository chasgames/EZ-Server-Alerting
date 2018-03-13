#!/bin/bash
ALERT=15
df -P | grep -vE "Filesystem|tmpfs|cdrom|/dev/loop" | awk '{ print $5 " " $1 " " $6}' | while read output;
do
   usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1 )
   partition=$(echo $output | awk '{ print $2 }' )
   folder=$(echo $output | awk '{ print $3 }' )
topfiles=`sudo du -Sh $folder  --exclude=/proc --exclude=/mnt | sort -rh | head -5`
   if [ $usep -ge $ALERT ]; then
      echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)"
      echo -e "Top files \n$topfiles"
   fi
done
