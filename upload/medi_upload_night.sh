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
	echo "uploading"
	rm -r /home/medi/upload_so							> upload.log	
	unzip -q  /home/medi/upload_so.zip					>> upload.log
	cp -a /home/medi/upload_so/* /home/medi/upload/		>> upload.log	
	
	######### dce #########
	sh	/home/medi/upload/dce/night067/startup.sh		>> upload.log	
	sh	/home/medi/upload/dce/night115/startup.sh		>> upload.log	
	sh	/home/medi/upload/dce/night210/startup.sh		>> upload.log

	######### zce #########
	sh	/home/medi/upload/zce/night169/startup.sh		>> upload.log	
	sh	/home/medi/upload/zce/night110/startup.sh		>> upload.log	
	sh	/home/medi/upload/zce/night96/startup.sh		>> upload.log	

	######### shfe #########
	sh	/home/medi/upload/shfe/night21-00/startup.sh		>> upload.log	
	sh	/home/medi/upload/shfe/night211/startup.sh		>> upload.log	
	sh	/home/medi/upload/shfe/night225/startup.sh		>> upload.log	


	cat "upload.log" | grep "WARNING" | mail -s "WARINGING for uploading so files." 2684027160@qq.com
	cat "upload.log" | grep "WARNING" | mail -s "WARINGING for uploading so files." 17199883@qq.com
	echo "################ 请检查如下警告#####################################"
	cat "upload.log" | grep "WARNING"  
	echo "uploaded"
}

 
enter_cur_dir
upload_files                                                                                                                                           
      
