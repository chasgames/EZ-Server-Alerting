#!/bin/bash

mypidfile=/tmp/mrlocky.pid

if [ -e $mypidfile ]; then
  echo "script is already running"
  exit 1
fi

# Make sure PID file is removed on program exit.
trap "rm -f -- '$mypidfile'" EXIT

# Create a file with current PID to indicate that process is running.
echo $$ > "$mypidfile"

if [ "$FIRSTRUN" -eq 1 ]; then
cp /etc/passwd /var/tmp/alerting-comp-pw
    sed -i 's/FIRSTRUN=1/FIRSTRUN=0/g' settings.conf
fi

while inotifywait -e attrib /etc/passwd; do

ntfy send "$(
echo ":key: /etc/passwd has changed, New user has been added or something has changed about a user"
echo -e "The differences:\n"
grep -Fxvf /var/tmp/alerting-comp-pw /etc/passwd
)"

cp /etc/passwd /var/tmp/alerting-comp-pw
#    awk -F: '($3 >= 1000) {print $1}' /etc/passwd | xargs -I{} passwd -S {} | awk '{print $1,$3}'
done
