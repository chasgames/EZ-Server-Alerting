#!/bin/bash

CURRENTHASH=$(sha256sum /etc/passwd)
OLDHASH=$(cat /var/tmp/passwdcheck)

if [ "$CURRENTHASH" ==  "$OLDHASH" ]; then
    echo good
else
    echo bad
fi

