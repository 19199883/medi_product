#!/bin/bash

##################
# 该脚本放在zce-trade1服务器上，用来启动zce-quote 服务器上的night110。
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

echo "------------night110 is starting--------"
remoteip="u910019@172.22.1.47"
ssh $remoteip "sh /home/u910019/medi/night110/x-zce/start.sh"
echo "------------night110 hase started--------"

