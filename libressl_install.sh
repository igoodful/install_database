#!/bin/bash
libressl_version='3.7.2'
libressl_file_dir="libressl-${libressl_version}"
libressl_file_tz="${libressl_file_dir}.tar.gz"
install_time=$(date '+%Y%m%d%H%M%S')

function init(){
if [ -x /usr/local/libressl ];then
mv /usr/local/libressl /usr/local/libressl.$install_time
fi
mkdir -p /usr/local/libressl


}


function install(){

wget https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/$libressl_file_tz
if [ $? -ne 0 ];then
echo "wget $libressl_file_tz error"
exit 1
fi
tar -xzvf $libressl_file_tz
cd $libressl_file_dir
./configure --prefix=/usr/local/libressl
if [ $? -ne 0 ];then
echo "./config error"
exit 1
fi
make
if [ $? -ne 0 ];then
echo "make error"
exit 1
fi
make install
if [ $? -ne 0 ];then
echo "make install error"
exit 1
fi



}

function main(){


}
main
