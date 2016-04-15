#!/bin/bash
# configure
bin=`dirname "$0"`
DIR=`cd "$bin"; pwd`
. "${DIR}/config.sh"

BASE=~/movbench
LOGS=$BASE/logs
TS=`date "+%Y%m%d_%H%M%S"`
HOSTNAME=`hostname`
LOGFILE=$LOGS/movbench_web_${HOSTNAME}_$TS.log

cd $BASE
echo $TS > $LOGFILE
#./cpu_movbench.sh >> $LOGFILE
#./disk_movbench.sh >> $LOGFILE
#./OLTP_movbench.sh >> $LOGFILE
./web_movbench.sh >> $LOGFILE
