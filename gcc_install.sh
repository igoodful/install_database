#!/bin/bash

function gcc_install() {
	gcc_version=$1
	yum -y install centos-release-scl
	yum -y install devtoolset-${gcc_version}-gcc
	yum -y install devtoolset-${gcc_version}-gcc-c++
	yum -y install devtoolset-${gcc_version}-binutils
	scl enable devtoolset-${gcc_version} bash
	sed -i '/devtoolset/d' /etc/profile
	echo "source /opt/rh/devtoolset-${gcc_version}/enable" >>/etc/profile

}

gcc_install 11
