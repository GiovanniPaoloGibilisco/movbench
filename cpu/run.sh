#!/bin/bash
# configure
bin=`dirname "$0"`
bin=`cd "$bin"; pwd`
DIR=`cd $bin/../; pwd`
#. "${DIR}/config.sh"
#. "${bin}/config.sh"

${bin}/cpu_movbench.sh > cpu.log
${bin}/cpu_extract.sh cpu.log
rm cpu.log
