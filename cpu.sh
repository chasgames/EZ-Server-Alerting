#!/bin/bash
CPUALERT=1.01 #available precent left
getCPU=$(cat /proc/loadavg | awk '{print $1}')
#Have to use bc cos floating point comparison
if (( $(echo "$getCPU > $CPUALERT" | bc -l) )); then
ntfy send "$(
        echo ":zap: Running out of CPU $getCPU avg on $(hostname) as on $(date)"
        echo -e "Top CPU apps: \n"
ps axo pid,args,pcpu --sort -pcpu | head -n 5
)"
fi

