#!/bin/bash
# configure
bin=`dirname "$0"`
bin=`cd "$bin"; pwd`
DIR=`cd $bin/../; pwd`
. "${DIR}/config.sh"
. "${bin}/config.sh"

./cpu_movbench.sh > cpu.log
./cpu_extract.sh cpu.log
rm cpu.log
