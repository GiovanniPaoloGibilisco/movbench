#!/bin/bash

MAXTIME=180
THREADS=4

sysbench --test=oltp --oltp-table-size=10000 --mysql-db=sysbench --mysql-user=root --mysql-password=moviri prepare
sysbench --test=oltp --oltp-table-size=10000 --oltp-test-mode=complex --num-threads=$THREADS --max-time=$MAXTIME --mysql-db=sysbench --mysql-user=root --mysql-password=moviri run
sysbench --test=oltp --mysql-db=sysbench --mysql-user=root --mysql-password=moviri cleanup
