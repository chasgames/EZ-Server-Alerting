#!/bin/bash
source /etc/profile

DISPLAY=":0.0"          # Display on local host

echo "lol"
ntfy -v send "does it work" #> /dev/null 2>&1
echo "done"

exit 0;
