#!/bin/bash
source settings.conf

if [ "$HEALTHDELAY" -eq 0 ]; then
#./health/disk.sh
#./health/ram.sh
#bash ./health/cpu.sh
#my_dir="$(dirname "$0")"

. ./health/cpu.sh
# it will execute the script in the current shell without forking a sub shell. this is so we can share the source file
fi
