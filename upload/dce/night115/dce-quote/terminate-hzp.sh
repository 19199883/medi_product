#!/bin/bash

##################
# 该脚本放在dce-qote服务器上，用来盘中停止night115，并清除仓位。
# 
#
#######################################

program_name="x-night115"

# the directory where this script file is.
function enter_cur_dir()
{
	 this_dir=`pwd`
	 dirname $0|grep "^/" >/dev/null
	 if [ $? -eq 0 ];then
		 this_dir=`dirname $0`
	 else
		 dirname $0|grep "^\." >/dev/null
		 retval=$?
		 if [ $retval -eq 0 ];then
			 this_dir=`dirname $0|sed "s#^.#$this_dir#"`
		 else
			 this_dir=`dirname $0|sed "s#^#$this_dir/#"`
		 fi
	 fi

	cd $this_dir
}

enter_cur_dir

rm *.pos
rm ../../day115/x-dce/*.pos

#kill process and exit
pkill --signal SIGUSR1  $program_name 

echo "after kill"
pid=$(ps -e  |grep $program_name | awk '{print $1}')
len=${#pid}
echo "len:${len}"
while [ $len -gt 0  ]
do
	pid=$(ps -e  |grep $program_name | awk '{print $1}')
	len=${#pid}
	echo "len:${len}"
	echo "pid:${pid}"
	sleep 1
done

echo "wake up"

