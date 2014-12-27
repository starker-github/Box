#!/bin/bash

if [ $# -lt 1 ]; then
        echo "Usage:    wifigateway.sh <device, such as wlan0>"
        exit
fi

IP=`ifconfig $1 | sed -n 's/inet \S*:\([^ ]*\).*/\1/p'`
echo $1"'s IP = "$IP
ROUTE=`echo $IP | sed -n 's/\(.*\)\..*/\1.1/p'`
echo $1"'s ROUTE = "$ROUTE

sudo route delete default
sudo route add default gw $ROUTE
sudo route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.2.1
exit
