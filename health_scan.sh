#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/EZ-Server-Alerting
#ntfy send "test omg 1min"
source settings.conf

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ "$HEALTHDELAY" -eq 0 ]; then
#./health/disk.sh
#./health/ram.sh
#bash ./health/cpu.sh
my_dir="$(dirname "$0")"

echo $my_dir
. $my_dir/health/disk.sh
. $my_dir/health/ram.sh
. $my_dir/health/cpu.sh

# it will execute the script in the current shell without forking a sub shell. this is so we can share the source file
fi
