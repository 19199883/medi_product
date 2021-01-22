#!/usr/bin/bash
AY_NIGHT=day

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
	ssh -p 8012							  u910019@1.193.38.91 'rm /home/u910019/medi/day223/x-zce/*day.so'
	ssh -p 8012							  u910019@1.193.38.91 'rm /home/u910019/medi/day223/x-zce/*.txt'
	ssh -p 8012							  u910019@1.193.38.91 'rm /home/u910019/medi/day223/x-zce/tools/*.txt'
	scp -qCp -P 8012 ./files/*.csv			 u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/tools/
	scp -qCp -P 8012 ./files/*.csv			 u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/
	scp -qCp -P 8012 ./files/*.txt			 u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/tools/
	scp -qCp -P 8012 ./files/*.txt		     u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/
	scp -qCp -P 8012 ./files/packaged/*.so    u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/

	ssh -p 8012						  u910019@1.193.38.91 'rm /home/u910019/medi/day223/x-zce/tools/*.log'
	ssh -p 8012						  u910019@1.193.38.91 '/home/u910019/medi/day223/x-zce/tools/configurator.py'
	scp -qCp -P 8012						  u910019@1.193.38.91:/home/u910019/medi/day223/x-zce/tools/configurator.log ./
	cat ./configurator.log
	ssh -p 8012						  u910019@1.193.38.91 'sh /home/u910019/medi/day223/x-zce/pos_calc.sh'
	ssh -p 8012						  u910019@1.193.38.91 'sh /home/u910019/medi/day223/x-zce/pos_redis.sh'
}

enter_cur_dir
encrypt_so
upload_files
