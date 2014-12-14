#!/bin/sh

# kernel toolchain
#export PATH=$PATH:$PWD/prebuilts/gcc/linux-x86/mips/mips-4.4.3/bin
#export CROSS_COMPILE=mips-linux-gnu-
export PATH=$PATH:$PWD/prebuilts/gcc/linux-x86/mips/mipsel-linux-android-4.6/bin
export CROSS_COMPILE=mipsel-linux-android-

cd kernel;make zImage -j8;cd ..
out/host/linux-x86/bin/mkbootimg  --kernel kernel/arch/mips/boot/compressed/zImage --ramdisk /home/tao/work/filesystem/ramfs.cpio.gz --output ./boot-ram-linux.img

echo 
echo "Make boot-ram-linux.img:"
echo 

sync
#cp boot-ram-linux.img /tao/burn_bin/zpad80/tmp/
cp boot-ram-linux.img /tao/burn_bin/grus/ramdisk/
sync
