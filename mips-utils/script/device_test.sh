#!/system/bin/sh
/system/bin/ls /dev/bus/usb/001/003
echo $?

if [ $? -eq 1 ]; then
	echo "No 001/003"
else
	echo "reboot"
	/system/bin/reboot
fi
