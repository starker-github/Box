#!/bin/bash

ORIG_MD5="45adbd143724874d78bd9547359ea01a"
PATH=/mnt/sdcard
#PATH=/media/tao/5156-F3DB
FILE=512M
count=0

echo "cp test $PATH/src/$FILE"
echo "cp test $PATH/src/$FILE" > cp_test.txt

while [ 1 ];
do
echo "======== $count ========"
echo "======== $count ========" >> cp_test.txt
/bin/date >> cp_test.txt
/bin/cp $PATH/src/$FILE $PATH/dst
/bin/sync
echo 3 >/proc/sys/vm/drop_caches

TEST_MD5=`/usr/bin/md5sum $PATH/dst/$FILE | /usr/bin/cut -d' ' -f1`

if [ "$TEST_MD5" != "$ORIG_MD5" ]; then
	echo "copy fail, TEST_MD5=$TEST_MD5"
	echo "copy fail, TEST_MD5=$TEST_MD5" >> cp_test.txt
fi

(( count++ ))
/bin/rm $PATH/dst/$FILE
/bin/sync
echo 3 >/proc/sys/vm/drop_caches

done;
