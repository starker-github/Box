#!/bin/bash
if [ $# -eq 1 ];then
	cp output/target/nv.img $1
	cp output/target/appfs.cramfs output/target/usrdata.jffs2 output/target/updater.cramfs $1
	cp output/target/appfs.ext4 output/target/updater.ext4 $1
else
	echo "Usage: cp.sh [path]"
fi
