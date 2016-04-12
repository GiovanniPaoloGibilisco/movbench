#!/bin/bash

BASE=~/movbench
LOGS=$BASE/logs
TS=`date "+%Y%m%d_%H%M%S"`
LOGFILE=$LOGS/movbench_$TS.log

cd $BASE
echo $TS > $LOGFILE
#./cpu_movbench.sh >> $LOGFILE
#./disk_movbench.sh >> $LOGFILE
#./OLTP_movbench.sh >> $LOGFILE
./web_movbench.sh >> $LOGFILE
