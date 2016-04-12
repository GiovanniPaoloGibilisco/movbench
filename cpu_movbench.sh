#!/bin/bash
# configure
bin=`dirname "$0"`
DIR=`cd "$bin"; pwd`
. "${DIR}/config.sh"

sysbench --num-threads=4 --test=cpu --cpu-max-prime=25000 run
