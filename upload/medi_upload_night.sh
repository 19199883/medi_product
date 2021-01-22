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
	unzip -q  /home/medi/upload_so.zip
	cp -a /home/medi/upload_so/* /home/medi/upload/
	
	######### dce #########
	sh	/home/medi/upload/dce/night067/startup.sh
	sh	/home/medi/upload/dce/night115/startup.sh
	sh	/home/medi/upload/dce/night210/startup.sh

	######### zce #########
	sh	/home/medi/upload/zce/night21-00/startup.sh
	sh	/home/medi/upload/zce/night211/startup.sh
	sh	/home/medi/upload/zce/night225/startup.sh

	######### shfe #########
	sh	/home/medi/upload/shfe/night110/startup.sh
	sh	/home/medi/upload/shfe/night169/startup.sh
	sh	/home/medi/upload/shfe/night96/startup.sh
}

 
enter_cur_dir
upload_files                                                                                                                                           
      
