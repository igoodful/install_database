#!/bin/bash

function print_versions() {
        curl https://www.boost.org/users/history/ | grep Version | awk -F'<|>' '{print $7}' | grep '^Version'
}

function download_boost() {
        boost_version=$1
        wget https://nchc.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
        tar -xzvf boost_1_59_0.tar.gz

}

function main() {
        print_versions
        download_boost 1.59.0

}
main
