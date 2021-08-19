#!/bin/bash

##################
# 该脚本放在dce-trade1服务器上，用来停止dce-quote 服务器上的night115.。
# 由hzp操作.
# 
#
#######################################


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

echo "------------night115 is terminating--------"
remoteip="u910028@172.18.113.133"
ssh $remoteip "sh /home/u910028/medi/night115/x-dce/terminate-hzp.sh"
echo "------------night115 terminated--------"

