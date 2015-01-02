#!/bin/bash

if [ $# -eq 1 ];then
	if [ $1x == "1"x ];then
		echo "enable touchpad"
		synclient touchpadoff=0
	elif [ $1x == "0"x ];then
		echo "disable touchpad"
		synclient touchpadoff=1
	fi
else
	echo "Usage: touchpad.sh 0/1 (disable/enable)"
fi
