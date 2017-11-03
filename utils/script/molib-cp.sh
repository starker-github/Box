#!/bin/bash
if [ $# -eq 1 ];then
	rm -rf $1/output/molib/*
	cp -a output/molib/* $1/output/molib
else
	echo "Usage: molib-cp.sh [mozart-path]"
fi
