#!/bin/bash
echo "https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-8.0.10/source/tarball/percona-xtrabackup-8.0.10.tar.gz"
echo "https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-8.0.28-20/source/tarball/percona-xtrabackup-8.0.28-20.tar.gz"
echo "https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.28/source/tarball/percona-xtrabackup-2.4.28.tar.gz"
echo "8.0.10,8.0.28-20,"

function xtrabackup_install() {
        local cpu_nums="$(cat /proc/cpuinfo | grep processor | wc -l)"
        local xtrabackup_version=$1
        local xtrabackup_url=""
        local xtrabackup_archive="percona-xtrabackup-${xtrabackup_version}.tar.gz"
        local xtrabackup_dir='/usr/local/percona-xtrabackup-${xtrabackup_version}'
        if echo $xtrabackup_version | grep 8.0; then
                xtrabackup_url="https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-${xtrabackup_version}/source/tarball/percona-xtrabackup-${xtrabackup_version}.tar.gz"
        elif echo $xtrabackup_version | grep 2.4; then
                xtrabackup_url="https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-${xtrabackup_version}/source/tarball/percona-xtrabackup-${xtrabackup_version}.tar.gz"
        else
                echo "error"
                exit 1
        fi
        scl enable devtoolset-11 bash
        wget $xtrabackup_url
        tar -xzvf $xtrabackup_archive
        cd percona-xtrabackup-${xtrabackup_version}
        cmake3 -DWITH_BOOST=./ -DDOWNLOAD_BOOST=ON -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=OFF -DCMAKE_C_COMPILER=/opt/rh/devtoolset-11/root/usr/bin/gcc -DCMAKE_CXX_COMPILER=/opt/rh/devtoolset-11/root/usr/bin/g++ -DFORCE_INSOURCE_BUILD=1
        make -j${cpu_nums}
        make install

}

xtrabackup_install "8.0.10"
