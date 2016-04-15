FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    sysbench \
    && rm -rf /var/lib/apt/lists/*

ENV BENCHMARK_SCRIPT=
