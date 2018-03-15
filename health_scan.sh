#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
echo "1"
PATH=/usr/local/bin:/bin:/usr/bin:$DIR
source settings.conf

if [ "$HEALTHDELAY" -eq 0 ]; then
. ./health/disk.sh
. ./health/ram.sh
. ./health/cpu.sh
echo "done health checks"
integrity/inot_passwd.sh &
echo "what"
integrity/inot_shadow.sh &
echo "what2"

# it will execute the script in the current shell without forking a sub shell. this is so we can share the source file
fi
