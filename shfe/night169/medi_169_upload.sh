
#!/usr/bin/bash

DAY_NIGHT=night

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
	scp -P 44163 ./files/*.csv u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/tools/
	scp -P 44163 ./files/*.csv u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/
	scp -P 44163 ./files/*.txt u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/tools/
	scp -P 44163 ./files/*.txt u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/
	scp -P 44163 ./files/packaged/*.so 	  u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/

	ssh -p 44163  u910019@101.231.3.117 'rm /home/u910019/medi/night169/x-shfe/tools/*.log'
	ssh -p 44163  u910019@101.231.3.117 '/home/u910019/medi/night169/x-shfe/tools/configurator.py'
	scp -P 44163  u910019@101.231.3.117:/home/u910019/medi/night169/x-shfe/tools/configurator.log ./
	cat ./configurator.log
}

enter_cur_dir
encrypt_so
upload_files


