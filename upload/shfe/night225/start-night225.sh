#!/bin/bash

##################
# 该脚本放在hzp的云服务器上，用来盘中重启程序使用。
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

echo "------------night225 is starting--------"
remoteip="-p 44163 u910019@101.231.3.117"
ssh $remoteip "sh /home/u910019/medi/night225/x-shfe/start-hzp.sh"
echo "------------night225 has started--------"

