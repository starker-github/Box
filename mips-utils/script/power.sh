#!/system/bin/sh
COUNT=0
while [ 1 ];
do
sendevent /dev/input/event1 1 116 1
sendevent /dev/input/event1 0 0 0
sendevent /dev/input/event1 1 116 0
sendevent /dev/input/event1 0 0 0
busybox sleep 2
echo "count="$COUNT
((COUNT++))
done;
