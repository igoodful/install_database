#!/bin/bash
echo "https://cmake.org/files/v3.25/cmake-3.25.2.tar.gz"
echo "https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-x86_64.tar.gz"
cpu_nums=$(cat /proc/cpuinfo | grep processor | wc -l)
cmake_version='3.5.2'
cmake_install_dir="/usr/local/cmake"
init_time=$(date '+%Y%m%d%H%M%S')

function check() {
        if [ -x $cmake_install_dir ]; then
                echo "$cmake_install_dir exists"
                exit 1
        fi
        which cmake
        if [ $? -ne 0 ]; then
                echo "cmake is not exists"
        else

                cmake_bin_dir=$(which cmake)

        fi

        if [ -f /usr/bin/cmake ]; then
                mv /usr/bin/cmake /usr/bin/cmake.$init_time
        fi
        if [ -d /usr/local/cmake ]; then
                mv /usr/local/cmake /usr/local/cmake.$init_time
        fi

        if [ -f /usr/bin/ccmake ]; then
                mv /usr/bin/ccmake /usr/bin/ccmake.$init_time
        fi
        if [ -f /usr/bin/cpack ]; then
                mv /usr/bin/cpack /usr/bin/cpack.$init_time
        fi
        if [ -f /usr/bin/ctest ]; then
                mv /usr/bin/ctest /usr/bin/ctest.$init_time
        fi

}

cmake_install() {
        #wget https://github.com/Kitware/CMake/releases/download/v${cmake_version}/cmake-${cmake_version}.tar.gz
        wget https://cmake.org/files/v3.5/cmake-${cmake_version}.tar.gz
        if [ -f cmake-${cmake_version}.tar.gz ]; then
                tar -xzvf cmake-${cmake_version}.tar.gz
                if [ $? -ne 0 ]; then
                        echo "tar -xzvf cmake-${cmake_version}.tar.gz error"
                        exit 1
                fi
                cd cmake-${cmake_version}
                ./bootstrap --prefix=/usr/local/cmake
                if [ $? -ne 0 ]; then
                        echo "./bootstrap --prefix=/usr/local/cmake error"
                        exit 1
                fi

                make -j $cpu_nums
                if [ $? -ne 0 ]; then
                        echo "make error"
                        exit 1
                fi
                make install
                if [ $? -ne 0 ]; then
                        echo "make install error"
                        exit 1
                fi
        else
                echo "error cmake-${cmake_version}.tar.gz is not exists"
                exit 1
        fi

        sed -i '/\/usr\/local\/cmake\/bin/d' /etc/profile
        echo "export PATH=/usr/local/cmake/bin:\$PATH" >>/etc/profile

}

cmake_install
