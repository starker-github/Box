#!/system/bin/sh
while [ 1 ];
do
date
cat /proc/meminfo
busybox sleep 30
done;
