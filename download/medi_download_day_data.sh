#!/bin/bash

DEST="data"

# the directory where this script file is
function enter_cur_dir(){
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

function download(){
	if [ ! -d $DEST ] 
	then
		mkdir $DEST 
	fi

	SRC_STRA_LOG="/home/u910019/medi/${DAY_NGT}/backup/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.${COMPRESS}"
	SRC_TICK_DATA="/home/u910019/md/download/${DAY_NGT}/backup/${EXT}_md_${DAY_NGT}_`date +%y%m%d`.tar.${COMPRESS}"

	scp  -P ${host_port} "${host_user}@${host_ip}:${SRC_STRA_LOG}" ${DEST}
	scp  -P ${host_port} "${host_user}@${host_ip}:${SRC_TICK_DATA}" ${DEST}
}


enter_cur_dir

# download data form shfe server for medi
host_ip="101.231.3.117"
host_user="u910019"
host_port="44163"
SUFFIX="day"
DAY_NGT="day"
EXT="sh"
COMPRESS="gz"
download

## strategy log
SRC="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.${COMPRESS}"
# added by wy 20181218
openssl des3 -d -k medi -salt -in ${SRC} | tar -C ${DEST} -xvzf -
# tar -C ${DEST} -xvzf ${SRC}
rm -r ${SRC}
DEST_GZ="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.gz"
tar -cvzf $DEST_GZ -C $DEST "./backup"
rm -r "${DEST}/backup"

## market data
SRC="${DEST}/${EXT}_md_${SUFFIX}_`date +%y%m%d`.tar.${COMPRESS}"
tar -C ${DEST} -xvzf ${SRC}
rm -r ${SRC}
DEST_GZ="${DEST}/${EXT}_md_${SUFFIX}_`date +%y%m%d`.tar.gz"
tar -cvzf $DEST_GZ -C $DEST "./backup"
rm -r "${DEST}/backup"

# download data form dce server for medi
host_ip="101.231.3.117"
host_user="u910019"
host_port="44153"
SUFFIX="day"
DAY_NGT="day"
EXT="dce"
COMPRESS="gz"
download
## strategy log
SRC="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.${COMPRESS}"
# added by wy 20181218
openssl des3 -d -k medi -salt -in ${SRC} | tar -C $DEST -xvzf -  
# tar -C $DEST -xvzf ${SRC}
rm -r $SRC
DEST_BJ2="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.gz"
tar -cvzf $DEST_BJ2 -C $DEST "./backup"
rm -r "${DEST}/backup"



# download data form zce server for medi
host_ip="1.193.38.91"
host_user="u910019"
host_port="8012"
SUFFIX="day"
DAY_NGT="day"
EXT="czce"
COMPRESS="gz"
download
## strategy log
SRC="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.${COMPRESS}"
# added by wy 20181218
openssl des3 -d -k medi -salt -in ${SRC} | tar -C $DEST -xvzf -  
# tar -C $DEST -xvzf ${SRC}
rm -r $SRC
DEST_BJ2="${DEST}/${EXT}_stra_${SUFFIX}_`date +%y%m%d`.tar.gz"
tar -cvzf $DEST_BJ2 -C $DEST "./backup"
rm -r "${DEST}/backup"

######################################
# download shfel level2 market data
#
####################################
LEV2MD="/home/u910019/market-data/shfe-lev2/day/backup/shfe_lev2_data_day_`date +%y%m%d`.tar.gz"
LEV2MD_GZ="shfe_lev2_data_day_`date +%y%m%d`.tar.gz"
#LEV2MD_BZ2="shfe_lev2_data_day_`date +%y%m%d`.tar.bz2"
echo "LEV2MD:${LEV2MD}:
echo "LEV2MD_GZ"${LEV2MD_GZ}"
echo "LEV2MD_BZ2:${LEV2MD_BZ2}"
scp  -P 44163  "u910019@101.231.3.117:${LEV2MD}" ${DEST}

# tar all data
cp -a ./contracts.csv ./data
tar  --remove-files -cvjf "data_`date +%y%m%d_day`.tar.bz2" ./data	

