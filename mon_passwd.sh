#!/bin/bash
source settings.conf

CURRENTHASH=$(sha256sum /etc/passwd)
OLDHASH=$(cat /var/tmp/passwdcheck)

if [ "$FIRSTRUN" -eq 1 ]; then
    echo "$CURRENTHASH" > /var/tmp/passwdcheck
    sed -i 's/FIRSTRUN=1/FIRSTRUN=0/g' settings.conf
fi

     


if [ "$CURRENTHASH" ==  "$OLDHASH" ]; then
    echo good
else
    echo bad
fi






