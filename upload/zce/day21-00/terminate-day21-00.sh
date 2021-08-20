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

echo "------------day21-00 is terminating--------"
remoteip="-p 8012 u910019@1.193.38.91"
ssh $remoteip "sh /home/u910019/medi/day21-00/x-zce/terminate-hzp.sh"
echo "------------day21-00 terminated--------"

