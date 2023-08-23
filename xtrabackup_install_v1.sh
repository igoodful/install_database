#!/bin/bash
https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-8.0.32-26/binary/tarball/percona-xtrabackup-8.0.32-26-Linux-x86_64.glibc2.17.tar.gz
https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.28/binary/tarball/percona-xtrabackup-2.4.28-Linux-x86_64.glibc2.17.tar.gz
percona-xtrabackup-2.4.5-Linux-x86_64.tar.gz
percona-xtrabackup-2.4.10-Linux-x86_64.libgcrypt20.tar.gz
percona-xtrabackup-2.4.16-Linux-x86_64.libgcrypt183.tar.gz
percona-xtrabackup-2.4.20-Linux-x86_64.el7.tar.gz
percona-xtrabackup-2.4.24-Linux-x86_64.glibc2.12.tar.gz
percona-xtrabackup-2.4.28-Linux-x86_64.glibc2.17.tar.gz

percona-xtrabackup-8.0.22-15-Linux-x86_64.glibc2.17.tar.gz
percona-xtrabackup-8.0.14-Linux-x86_64.glibc2.12.tar.gz
percona-xtrabackup-8.0.10-Linux-x86_64.el7.tar.gz
percona-xtrabackup-8.0.8-Linux-x86_64.libgcrypt153.tar.gz
percona-xtrabackup-8.0.4-Linux-x86_64.libgcrypt20.tar.gz

xtrabackup_install() {
        local xtrabackup_version="$1"
        i
        local xtrabackup_url=''
        local xtrabackup_archive=''
        local xtrabackup_dir=''

        if echo "$xtrabackup_version" | grep "2.4"; then
                xtrabackup_url="https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-${xtrabackup_version}/binary/tarball/percona-xtrabackup-${xtrabackup_version}-Linux-x86_64.glibc2.17.tar.gz"
                xtrabackup_archive="percona-xtrabackup-${xtrabackup_version}-Linux-x86_64.glibc2.17.tar.gz"
                xtrabackup_dir=''

        elif echo "$xtrabackup_version" | grep "8.0"; then
                local xtrabackup_url=''
                local xtrabackup_archive=''
                local xtrabackup_dir=''

        else
                echo "error,please input right version"
                exit 1

        fi
        local version=$(echo $xtrabackup_version | grep 8.0)
        local xtrabackup_url="https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-${xtrabackup_version}/binary/tarball/percona-xtrabackup-${xtrabackup_version}-Linux-x86_64.glibc2.17.tar.gz"
        local xtrabackup_archive="percona-xtrabackup-${xtrabackup_version}-Linux-x86_64.glibc2.17.tar.gz"
        local xtrabackup_dir="/usr/local/percona-xtrabackup-${xtrabackup_version}"

        if [ -d "${xtrabackup_dir}/bin" ]; then
                echo "percona-xtrabackup-${xtrabackup_version} is already installed."
        else
                wget "${xtrabackup_url}"
                tar -xzf "${xtrabackup_archive}"
                mv "percona-xtrabackup-${xtrabackup_version}" "${xtrabackup_dir}"
                echo "export PATH=\"${xtrabackup_dir}/bin:\$PATH\"" >>/etc/profile
                source /etc/profile
                xtrabackup --version
                echo "percona-xtrabackup-${xtrabackup_version} is now installed."
        fi
}

xtrabackup_install "8.0.32-26"

percona-xtrabackup-8.0.32-26.tar.gz
percona-xtrabackup-8.0.32-25.tar.gz
percona-xtrabackup-8.0.22-15.tar.gz
percona-xtrabackup-8.0.14.tar.gz
percona-xtrabackup-8.0.4.tar.gz
percona-xtrabackup-2.4.28.tar.gz
percona-xtrabackup-2.4.25.tar.gz
percona-xtrabackup-2.4.20.tar.gz
percona-xtrabackup-2.4.15.tar.gz
percona-xtrabackup-2.4.10.tar.gz
percona-xtrabackup-2.4.5.tar.gz
