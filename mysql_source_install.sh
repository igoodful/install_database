#!/bin/bash
echo "GCC 7.1+"
echo "make 3.75+"
echo "Boost C++"
echo "ncurses "
echo "bison 2.1+ 尽可能使用最新版本的bison"
echo " OpenSSL 1.0.1+"
echo "/usr/local/mysql"
function repo() {

}

function dowload_mysql() {

}

function mysql_install() {

        cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$mysql_basedir -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_0900_ai_ci

}
