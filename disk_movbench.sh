#!/bin/bash

RUNTIME=180
SIZE=2g
JOBS=2

# warm-up test
#fio --runtime=10 --time_based --name=randread --numjobs=$JOBS --rw=randread --random_distribution=pareto:0.9 --bs=8k --size=$SIZE --filename=fio.tmp > /dev/null

# actual-test
fio --runtime=$RUNTIME --time_based --name=randread --numjobs=$JOBS --rw=randread --random_distribution=pareto:0.9 --bs=8k --size=$SIZE --filename=fio.tmp --group_reporting
