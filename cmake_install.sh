#!/bin/bash
init_time=$(date '+%Y%m%d%H%M%S')
echo "https://cmake.org/files/v3.25/cmake-3.25.2.tar.gz"
echo "https://github.com/Kitware/CMake/releases/download/v3.25.3/cmake-3.25.3-linux-x86_64.tar.gz"

cmake_install() {
	local cmake_version=$1
	local cpu_nums=$(cat /proc/cpuinfo | grep processor | wc -l)

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



	wget https://github.com/Kitware/CMake/releases/download/v${cmake_version}/cmake-${cmake_version}.tar.gz

	if [ -f cmake-${cmake_version}.tar.gz ]; then
		tar -xzvf cmake-${cmake_version}.tar.gz
		cd cmake-${cmake_version}
		./bootstrap --prefix=/usr/local/cmake
		make -j $cpu_nums
		make install
	else
		echo "error cmake-${cmake_version}.tar.gz is not exists"
		exit 1
	fi
	
	sed -i '/\/usr\/local\/cmake\/bin/d' /etc/profile
	echo "export PATH=/usr/local/cmake/bin:\$PATH" >> /etc/profile

}

cmake_install "3.5.2"
