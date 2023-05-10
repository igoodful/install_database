#!/bin/bash
openssl_version='3.1.0'
openssl_filename="openssl-${openssl_version}.tar.gz"
install_dir="/usr/local/openssl-${openssl_version}"
install_dir_sed="\/usr\/local\/openssl-${openssl_version}"
install_time=$(date '+%Y%m%d%H%M%S')
# https://www.openssl.org/source/openssl-3.1.0.tar.gz

function openssl_bakup() {
	if [ -d $install_dir ]; then
		echo "$install_dir exists"
		exit 1
	else
		mkdir $install_dir
	fi

	if [ -f /usr/bin/openssl ]; then
		echo "mv /usr/bin/openssl /usr/bin/openssl.$install_time"
		mv /usr/bin/openssl /usr/bin/openssl.$install_time
	fi

	if [ -d /usr/include/openssl ]; then
		echo "mv /usr/include/openssl /usr/include/openssl.$install_time"
		mv /usr/include/openssl /usr/include/openssl.$install_time
	fi

	ls /usr/local/lib64/ | grep libssl.so
	if [ $? = 0 ]; then
		echo "please delete libssl.so"
		exit 1
	fi

	ls /usr/lib64/ | grep libcrypto.so
	if [ $? = 0 ]; then
		echo "please delete libcrypto.so"
		exit 1
	fi

}

function download() {
	rm -rf openssl-${openssl_version}.tar.gz
	wget https://www.openssl.org/source/$openssl_filename
}

function install() {
	tar -xzvf $openssl_filename
	cd openssl-${openssl_version}
	./config --prefix=$install_dir shared
	if [ $? = 0 ]; then
		echo "./config success"
	else
		echo "./config error"
		exit 1
	fi
	make
	if [ $? = 0 ]; then
		echo "make success"
	else
		echo "make error"
		exit 1
	fi
	make install
	if [ $? = 0 ]; then
		echo "make install success"
	else
		echo "make install error"
		exit 1
	fi

}

function openssl_new() {
	sed -i '/openssl/d' /etc/profile
	echo "export PATH=$install_dir/bin:$PATH" >> /etc/profile
	echo "export LD_LIBRARY_PATH=$install_dir/lib:\$LD_LIBRARY_PATH" >> /etc/profile
	source /etc/profile
}

function main() {
	openssl_bakup
	download
	install
	openssl_new

}

main
