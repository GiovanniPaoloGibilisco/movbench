FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    sysbench \
    wget \
    bc \
    && rm -rf /var/lib/apt/lists/*

ENV BENCHMARK_VERSION=0.2.2
ENV BENCHMARK_ARCHIVE="https://github.com/GiovanniPaoloGibilisco/movbench/archive/v$BENCHMARK_VERSION.tar.gz"

RUN wget "$BENCHMARK_ARCHIVE" \
    && mv "v$BENCHMARK_VERSION.tar.gz" benchmark.tar.gz \
    && tar -xzf benchmark.tar.gz \
    && rm benchmark.tar.gz 

CMD movbench-${BENCHMARK_VERSION}/cpu/run.sh
