#!/bin/bash

##################
# 该脚本放在shfe-trade1服务器上，用来启动day211。
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

echo "------------day211 is starting--------"
sh start.sh
echo "------------day211 hase started--------"

