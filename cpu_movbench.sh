#!/bin/bash
sysbench --num-threads=4 --test=cpu --cpu-max-prime=25000 run
