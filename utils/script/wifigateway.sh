#!/bin/bash

if [ $# -lt 1 ]; then
        echo "Usage:    wifigateway.sh <device, such as wlan0>"
        exit
fi

IP=`ifconfig $1 | sed -n 's/inet\s*\([0-9.]*\).*/\1/p'`
echo $1"'s IP = "$IP
ROUTE=`echo $IP | sed -n 's/\(.*\)\..*/\1.1/p'`
echo $1"'s ROUTE = "$ROUTE

if [ x$ROUTE == x ];then
	exit
fi

#while [ 1 ];
#do
#	route | grep default > /dev/null
#	if [ $? -eq 0 ]; then
#		sudo route delete default
#	else
#		break
#	fi
#done
sudo route delete default
sudo route delete default
sudo route add default gw $ROUTE
sudo route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.2.1
sudo route add -net 106.37.171.196 netmask 255.255.255.255 gw 192.168.2.1
exit
