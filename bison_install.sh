#!/bin/bash
bison_version='2.6.5'
bison_dir="bison-${bison_version}"
bison_targz="${bison_dir}.tar.gz"
print_version() {
        curl https://ftp.gnu.org/gnu/bison/ | grep .tar.gz | grep bison- | awk -F'<a href="' '{print $2}' | grep -v .sig | awk -F'">biso' '{print $1}' | grep -v '\-\-:'
}

install() {
        wget https://ftp.gnu.org/gnu/bison/${bison_targz}
        tar -xzvf ${bison_targz}
        cd ${bison_dir}
        ./configure
        make
        make install
}

check() {
        bison --version
}
