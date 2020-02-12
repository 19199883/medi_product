#!/usr/bin/bash
DAY_NIGHT=day

function encrypt_so
{
	cd ./files
	if [ ! -d packaged ]
	then 
		mkdir packaged
	fi
	
	rm ./packaged/*
	for cur_so in `ls  ./*.so`
	do
		echo "process ${cur_so}"
		tar -czvf - ${cur_so} | openssl des3 -salt -k 617999 -out ./packaged/${cur_so}  
	done
	
	cd ..
}

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
	ssh -p 44153						   u910019@101.231.3.117 'rm /home/u910019/medi/day115/x-dce/*day.so'
	ssh -p 44153						   u910019@101.231.3.117 'rm /home/u910019/medi/day115/x-dce/*.txt'
	ssh -p 44153						   u910019@101.231.3.117 'rm /home/u910019/medi/day115/x-dce/tools/*.txt'
	scp -Cp -P 44153             ./files/*.csv u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/tools/
	scp -Cp -P 44153             ./files/*.csv u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/
	scp -Cp -P 44153             ./files/*.txt u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/tools/
	scp -Cp -P 44153             ./files/*.txt u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/
	scp -Cp -P 44153 ./files/packaged/*.so     u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/

	ssh -p 44153						   u910019@101.231.3.117 'rm /home/u910019/medi/day115/x-dce/tools/*.log'
	ssh -p 44153						      u910019@101.231.3.117 '/home/u910019/medi/day115/x-dce/tools/configurator.py'
	scp -Cp -P 44153						   u910019@101.231.3.117:/home/u910019/medi/day115/x-dce/tools/configurator.log ./
	cat ./configurator.log
	ssh -p 44153						   u910019@101.231.3.117 'sh /home/u910019/medi/day115/x-dce/pos_calc.sh'
	ssh -p 44153						   u910019@101.231.3.117 'sh /home/u910019/medi/day115/x-dce/pos_redis.sh'
}
 
enter_cur_dir
encrypt_so
upload_files                                                                                                                                           
      
