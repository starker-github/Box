#!/bin/bash

./build/scripts/mkbootimg.sh zpad80
sync

if [ "$1" == "a" ]; then
#cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/ext4/
cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/ubi/
echo "ZPAD80 V1.2a"
sync
elif [ "$1" = "b" ]; then
cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/v1.2b/
echo "ZPAD80 V1.2b"
sync
else
	echo "Please select a or b"
	exit 1
fi
