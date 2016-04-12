#!/bin/bash
# configure
bin=`dirname "$0"`
DIR=`cd "$bin"; pwd`
. "${DIR}/config.sh"

MAXTIME=180
THREADS=4

sysbench --test=oltp --oltp-table-size=10000 --mysql-db=sysbench --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASS prepare
sysbench --test=oltp --oltp-table-size=10000 --oltp-test-mode=complex --num-threads=$THREADS --max-time=$MAXTIME --mysql-db=sysbench --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASS run
sysbench --test=oltp --mysql-db=sysbench --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASS cleanup
