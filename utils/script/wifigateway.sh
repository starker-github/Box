#!/bin/bash

if [ "$1" = "10" ]; then
sudo route delete default
sudo route add default gw 10.10.30.1
sudo route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.2.1
elif [ "$1" = "4" ]; then
sudo route delete default
sudo route add default gw 10.4.30.1
sudo route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.2.1
else
	echo "Please select 10 or 4!"
fi

