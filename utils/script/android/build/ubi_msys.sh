#!/bin/bash

# The old partition
#sudo ./build/scripts/mkubifs.sh zpad80 2048 64 500 240 120
# The bigger partition
sudo ./build/scripts/mkubifs.sh zpad80 2048 64 300 500 40

if [ "$1" == "a" ]; then
sync
cp out/target/product/zpad80/system.img.ubifs /home/tao/Public/share/zpad80/ubi/
cp out/target/product/zpad80/userdata.img.ubifs /home/tao/Public/share/zpad80/ubi/
cp out/target/product/zpad80/cache.img.ubifs /home/tao/Public/share/zpad80/ubi/
echo "ZPAD80 V1.2a"
sync
elif [ "$1" = "b" ]; then
sync
cp out/target/product/zpad80/system.img.ubifs /home/tao/Public/share/zpad80/v1.2b/
cp out/target/product/zpad80/userdata.img.ubifs /home/tao/Public/share/zpad80/v1.2b/
cp out/target/product/zpad80/cache.img.ubifs /home/tao/Public/share/zpad80/v1.2b/
echo "ZPAD80 V1.2b"
sync
else
	echo "Please select a or b"
	exit 1
fi
