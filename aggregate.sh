#!/bin/bash
#usage: ./aggregate.sh movvml120
host=$1
duration=300
echo "TS;DURATION;WKLDNM;OBJNM;SUBOBJNM;VALUE;DS_WKLDNM" >> benchmark.csv
for file in logs/*
do
  #extract common fields
  logtype=$(basename $file | cut -f 2 -d "_")
  #extract hostname
  wkldnm="E4C Bench - $1"

  if [ "$logtype" = "web" ]
  then
    #extract the date
    date=$(basename $file | cut -f 4 -d "_")
    year=`expr substr $date 1 4`
    mon=`expr substr $date 5 2`
    day=`expr substr $date 7 2`

    #extract the time
    timestamp=$(basename $file | cut -f 5 -d "_")
    hour=`expr substr $timestamp 1 2`
    min=`expr substr $timestamp 3 2`
    sec=`expr substr $timestamp 5 2`

    #format the timestamp string
    timestamp="$year-$mon-$day $hour:$min:$sec"
    #extract response time
    response_time=$(cat $file | grep wall | cut -f 5 -d " " | cut -f 1 -d s)
    objname=WEB_RESPONSE_TIME
    subobjname=GLOBAL
    value=$response_time
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    #extract number of files downloaded
    downloaded_files=$(cat $file | grep Downloaded | cut -f 2 -d " ")
    objname=WEB_TOTAL_HITS
    subobjname=GLOBAL
    value=$downloaded_files
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    #other metrics not currently exported
    size=$(cat $file | grep Downloaded | cut -f 4 -d " ")
    download_time=$(cat $file | grep Downloaded | cut -f 6 -d " " | cut -f 1 -d s)
    speed=$(cat $file | grep Downloaded | cut -f 2 -d "(" | cut -f 1 -d ")")

  else
    #Parse the log of performance benchmarks
    #extract the date
    date=$(basename $file | cut -f 2 -d "_")
    year=`expr substr $date 1 4`
    mon=`expr substr $date 5 2`
    day=`expr substr $date 7 2`

    #extract the time
    timestamp=$(basename $file | cut -f 3 -d "_")
    hour=`expr substr $timestamp 1 2`
    min=`expr substr $timestamp 3 2`
    sec=`expr substr $timestamp 5 2`

    #format the timestamp string
    timestamp="$year-$mon-$day $hour:$min:$sec"

    echo "perf time: $timestamp"
    cputime=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/avg/ {print $2}' | awk -F\m '{print $1}')
    cputime_sec=$(echo "scale=5; $cputime / 1000" | bc)
    objname=BYSET_ELAPSED_TIME
    subobjname=CPU
    value=$cputime_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    cpu_percentile=$(cat $file | grep "Maximum prime number checked in CPU test" -A 11 | awk '/95 percentile:/ {print $4}' | awk -F\m '{print $1}')
    cpu_percentile_sec=$(echo "scale=5; $cpu_percentile / 1000" | bc)
    objname=BYSET_ELAPSED_TIME_PEAK
    subobjname=CPU
    value=$cpu_percentile_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    iops=$( sed -n '35p' $file | cut -f 4 -d "=" | cut -f 1 -d ",")
    objname=BYSET_EVENT_RATE
    subobjname=IO
    value=$iops
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    io_lat_avg=$( sed -n '36p' $file | cut -f 4 -d "=" | cut -f 1 -d ",")
    io_lat_avg_sec=$(echo "scale=5; $io_lat_avg / 1000000" | bc)
    objname=BYSET_ELAPSED_TIME
    subobjname=IO
    value=$io_lat_avg_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    io_lat_perc=$( sed -n '41p' $file | cut -f 5 -d "[" | cut -f 1 -d "]")
    io_lat_perc_sec=$(echo "scale=5; $io_lat_perc / 1000000" | bc)
    objname=BYSET_ELAPSED_TIME_PEAK
    subobjname=IO
    value=$io_lat_perc_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    oltp_th=$(cat $file | grep "OLTP test statistics:" -A 19 | awk '/transactions/ {print $3}' | awk -F\( '{print $2}')
    objname=BYSET_EVENT_RATE
    subobjname=OLTP
    value=$oltp_th
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    oltp_trans_avg=$(cat $file | grep "OLTP test statistics:" -A 19 | awk '/avg/ {print $2}' | awk -F\m '{print $1}')
    oltp_trans_avg_sec=$(echo "scale=5; $oltp_trans_avg / 1000" | bc)
    objname=BYSET_ELAPSED_TIME
    subobjname=OLTP
    value=$oltp_trans_avg_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

    oltp_trans_perc=$(cat $file | grep "OLTP test statistics:" -A 19 | awk '/95 percentile:/ {print $4}' | awk -F\m '{print $1}')
    oltp_trans_perc_sec=$(echo "scale=5; $oltp_trans_perc / 1000" | bc)
    objname=BYSET_ELAPSED_TIME_PEAK
    subobjname=OLTP
    value=$oltp_trans_perc_sec
    echo "$timestamp;$duration;$wkldnm;$objname;$subobjname;$value;" >> benchmark.csv

  fi
done

