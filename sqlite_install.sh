#!/bin/bash
sqlite3_version='3420000'
sqlite3_package_dir="sqlite-autoconf-${sqlite3_version}"
sqlite3_package_targz="${sqlite3_package_dir}.tar.gz"

function install() {
        wget https://www.sqlite.org/2023/${sqlite3_package_targz}
        tar -xzvf ${sqlite3_package_targz}
        cd ${sqlite3_package_dir}
        ./configure --prefix=/usr/local
        make
        make install
        mv /usr/bin/sqlite3 /usr/bin/sqlite3_old
        ln -s /usr/local/bin/sqlite3 /usr/bin/sqlite3
        echo "/usr/local/lib" >/etc/ld.so.conf.d/sqlite3.conf
        ldconfig

}

function main() {
        install
}
main
