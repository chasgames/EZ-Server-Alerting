#!/bin/bash

source settings.conf #import thresholds

availRAM=$(awk '/^Mem/ {printf("%u", 100*$7/$2);}' <(free -m))
   if [ $availRAM -le $RAMALERT ]; then
ntfy send "$(

      echo ":ram: Running out of RAM $availRAM% on $(hostname) as on $(date)"
	echo -e "Top RAM apps: \n"
ps axo pmem,args,pid --sort -pmem,-rss,-vsz | head -n 5
#OLD ONEps axo pid,args,pmem,rss,vsz --sort -pmem,-rss,-vsz | head -n 5
)"

###ALERTDELAY###
sed -i 's/HEALTHDELAY=0/HEALTHDELAY=1/g' "$DIR"/settings.conf
echo "sed -i 's/HEALTHDELAY=1/HEALTHDELAY=0/g' "$DIR"/settings.conf" > "$DIR"/health/job.txt
at now + "$ALERT_DELAY_PERIOD" < "$DIR"/health/job.txt

   fi
