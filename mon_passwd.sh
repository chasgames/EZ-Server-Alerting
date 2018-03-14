#!/bin/bash
source settings.conf

#CURRENTHASH=$(sha256sum /etc/passwd)
#OLDHASH=$(cat /var/tmp/passwdcheck)

if [ "$FIRSTRUN" -eq 1 ]; then
#    echo "$CURRENTHASH" > /var/tmp/passwdcheck
cp /etc/passwd /var/tmp/alerting-comp-pw
    sed -i 's/FIRSTRUN=1/FIRSTRUN=0/g' settings.conf
fi

diff /etc/passwd /var/tmp/alerting-comp-pw
if [ $? -ne 0 ]; then
ntfy send "$(
echo ":key: /etc/passwd has changed, New user has been added or something has changed about a user"
echo -e "The differences:\n"
grep -Fxvf /etc/passwd /var/tmp/alerting-comp-pw
)"
cp /etc/passwd /var/tmp/alerting-comp-pw

fi







