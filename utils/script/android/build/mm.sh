#!/bin/bash

if [ "$1" == "a" ]; then
#./build/scripts/mbuild_nand allimg zpad80 zpad80_nand
./build/scripts/mbuild_nand allimg zpad80 zpad80_nand_ubi
cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/ubi
echo "ZPAD80 V1.2a"
./ubi_msys.sh a
elif [ "$1" = "b" ]; then
#./build/scripts/mbuild_nand allimg zpad80 zpad80_nand_ubi_ldo
./build/scripts/mbuild_nand allimg zpad80 zpad80_nand_ubi
cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/v1.2b
echo "ZPAD80 V1.2b"
./ubi_msys.sh b
else
	echo "Please select a or b"
	exit 1
fi
#sync
#cp out/target/product/zpad80/boot.img /home/tao/Public/share/zpad80/ubi
#cp out/target/product/zpad80/system.img.bin /home/tao/Public/share/zpad80/ext4/
#sync
