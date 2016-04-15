#!/bin/bash
#usage: ./aggregate.sh movvml120
file=$1

cputime=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/avg/ {print $2}' | awk -F\m '{print $1}')
cputime_sec=$(echo "scale=5; $cputime / 1000" | bc)
value=$cputime_sec
echo "cpu_time_avg=$value"

cputime_min=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/min/ {print $2}' | awk -F\m '{print $1}')
cputime_min_sec=$(echo "scale=5; $cputime_min / 1000" | bc)
value=$cputime_min_sec
echo "cpu_time_min=$value"

cputime_max=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/max/ {print $2}' | awk -F\m '{print $1}')
cputime_max_sec=$(echo "scale=5; $cputime_max / 1000" | bc)
value=$cputime_max_sec
echo "cpu_time_max=$value"

cpu_percentile=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/95 percentile:/ {print $4}' | awk -F\m '{print $1}')
cpu_percentile_sec=$(echo "scale=5; $cpu_percentile / 1000" | bc)
value=$cpu_percentile_sec
echo "cpu_time_95th_perc=$value"

