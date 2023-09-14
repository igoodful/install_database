#!/bin/bash
yum -y install make automake libtool pkgconfig libaio-devel openssl-devel mysql-devel
cd /usr/src/
wget https://github.com/akopytov/sysbench/archive/refs/tags/1.0.20.tar.gz
tar xvf 1.0.20.tar.gz
cd sysbench-1.0.20/
./autogen.sh
./configure
make -j 4
make install
# ls -l /usr/local/share/sysbench
