#!/bin/bash
# configure
bin=`dirname "$0"`
DIR=`cd "$bin"; pwd`
. "${DIR}/config.sh"
wget --recursive -p -e robots=off --no-verbose "http://$WEB_SERVER_ADDR" 2>&1 

rm -r $WEB_SERVER_ADDR
