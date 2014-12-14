#!/bin/sh
# 自动设置ip地址
NEW_IP=`udhcpc -i wlan0 | grep obtained | sed 's/Lease of \(.*\) obtained.*/\1/'` 

if [ x"$NEW_IP" == x ]; then
	echo "Obtain IP failed"
	exit 1
else
	echo "Obtain IP: $NEW_IP"
	ifconfig wlan0 $NEW_IP netmask 255.255.255.0
fi
udhcpc -i wlan0 | grep obtained | sed 's/Lease of \(.*\) obtained.*/\1/p'

