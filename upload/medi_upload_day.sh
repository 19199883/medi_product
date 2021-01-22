#!/usr/bin/bash

# the directory where this script file is.
function enter_cur_dir(){
         this_dir=`pwd`
         dirname $0|grep "^/" >/dev/null
         if [ $? -eq 0 ]
         then
                         this_dir=`dirname $0`
         else
                         dirname $0|grep "^\." >/dev/null
                         retval=$?
                         if [ $retval -eq 0 ]
                         then
                                         this_dir=`dirname $0|sed "s#^.#$this_dir#"`
                         else
                                         this_dir=`dirname $0|sed "s#^#$this_dir/#"`
                         fi
         fi

        cd $this_dir
}

function upload_files
{
	rm -r /home/medi/upload_so
	unzip -q /home/medi/upload_so.zip
	cp -a /home/medi/upload_so/* /home/medi/upload/
	
	######### dce #########
	sh	/home/medi/upload/dce/day067/startup.sh
	sh	/home/medi/upload/dce/day115/startup.sh
	sh	/home/medi/upload/dce/day210/startup.sh

	######### zce #########
	sh	/home/medi/upload/zce/day21-00/startup.sh
	sh	/home/medi/upload/zce/day211/startup.sh
	sh	/home/medi/upload/zce/day225/startup.sh

	######### shfe #########
	sh	/home/medi/upload/shfe/day110/startup.sh
	sh	/home/medi/upload/shfe/day169/startup.sh
	sh	/home/medi/upload/shfe/day96/startup.sh
}

 
enter_cur_dir
upload_files                                                                                                                                           
      
