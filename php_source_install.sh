#!/bin/bash
php_version='8.1.17'
cpu_nums=$(cat /proc/cpuinfo | grep processor | wc -l)

function remove() {
        yum -y remove php*

}

function download() {
        if [ -f php-${php_version}.tar.gz ]; then
                echo "php-${php_version}.tar.gz exists"
        else
                wget https://www.php.net/distributions/php-${php_version}.tar.gz
        fi
}

function install() {
        tar -xzvf php-${php_version}.tar.gz
        cd php-${php_version}
        # --with-ldap
        ./configure --prefix=/usr/local/php8 --exec-prefix=/usr/local/php8 --bindir=/usr/local/php8/bin --sbindir=/usr/local/php8/sbin --includedir=/usr/local/php8/include --libdir=/usr/local/php8/lib/php --mandir=/usr/local/php8/php/man --with-config-file-path=/usr/local/php8/conf --with-mysql-sock=/home/work/mysql_3306/tmp/mysql.sock --with-mhash --with-openssl --with-mysqli=shared,mysqlnd --with-pdo-mysql=shared,mysqlnd --with-gd --with-iconv --with-zlib --enable-zip --enable-inline-optimization --disable-debug --disable-rpath --enable-shared --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-mbregex --enable-mbstring --enable-ftp --enable-pcntl --enable-sockets --with-xmlrpc --enable-soap --without-pear --with-gettext --enable-session --with-curl --with-jpeg-dir --with-freetype-dir --enable-opcache --enable-fpm --without-gdbm --disable-fileinfo
        if [ "$?" == "0" ]; then
                make -j${cpu_nums}
                if [ "$?" == "0" ]; then
                        make install
                else
                        echo "make error"
                        exit 1
                fi
        else
                echo "configure error"
                exit 1
        fi

}

function main() {
        remove
        download
        install

}
main
