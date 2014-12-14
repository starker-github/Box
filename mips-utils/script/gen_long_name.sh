#!/bin/bash

NAME=4000000000000000000
LOOP=0

if [ $# -lt 2 ];
then
	echo "Usage: mk_long_name.sh src dst"
	exit
fi

while [ 1 ];
do
	if [ $LOOP -le 2 ];
	then
		echo $2""$NAME
		dd bs=128 count=1 if=$1 of=$2IMG_md_20120921142223_$NAME.jpg
	else
		echo $NAME" exit!!!"
		exit
	fi
((NAME++))
((LOOP++))
done;
