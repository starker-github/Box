#!/bin/bash
goagent=`ps -ef | grep "python.* proxy.py" | head -n 1 | awk '{print $2}'`
echo "goagent pid = $goagent"
echo -n "====>> "
ps -ef | grep "python.* proxy.py" | head -n 1
echo "y or n ?"
read -N 1 BOOL
echo ""
if [ ${BOOL}x = "y"x ];then
	echo "Kill $goagent"
	sudo kill -9 $goagent
	sudo sh /mnt/tao/Utils/goagent/proxy.sh
elif [ ${BOOL}x = "n"x ];then
	goagent=`ps -ef | grep "python.* proxy.py" | tail -n 1 | awk '{print $2}'`
	echo "goagent pid = $goagent"
	echo -n "====>> "
	ps -ef | grep "python.* proxy.py" | tail -n 1
	echo "y or n ?"
	read -N 1 BL
	if [ ${BL}x = "y"x ];then
		echo "Kill $goagent"
		sudo kill -9 $goagent
		sudo sh /mnt/tao/Utils/goagent/proxy.sh
	fi
else
	echo "Kill nothing"
fi
