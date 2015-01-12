#!/bin/bash

if [ $# -eq 1 ]; then
	case $1 in
	on)
		echo 1 > /sys/class/leds/led/brightness
	;;
	off)
		echo 0 > /sys/class/leds/led/brightness
	;;
	blink)
		echo timer > /sys/class/leds/led/trigger
		echo 800 > /sys/class/leds/led/delay_on
		echo 800 > /sys/class/leds/led/delay_off
	;;
	esac
else
	echo "Usage: $0 on/off/blink"
fi
