#!/bin/bash
wget --recursive -p -e robots=off --no-verbose http://movvml120.lab.moviri.com 2>&1 

rm -r movvml120.lab.moviri.com
