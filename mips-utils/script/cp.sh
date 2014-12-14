#!/bin/sh

ORIG_MD5="fa20b552195ce0a6853a5c98cbb9cb6d"
echo "udisk test" > udisk_test.txt

while [ 1 ];
do
echo "u-disk test..."
date >> udisk_test.txt
echo "u-disk test..." >> udisk_test.txt
busybox cp /mnt/usb/src/test.bin /mnt/usb/dst
sync
echo 3 >/proc/sys/vm/drop_caches

TEST_MD5=`md5sum /mnt/usb/dst/test.bin | busybox cut -d' ' -f1`

if [ "$TEST_MD5" != "$ORIG_MD5" ]; then
	echo "copy fail, TEST_MD5=$TEST_MD5"
	echo "copy fail, TEST_MD5=$TEST_MD5" >> udisk_test.tt
fi

rm /mnt/usb/dst/test.bin
sync
echo 3 >/proc/sys/vm/drop_caches

done;
