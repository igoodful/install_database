#!/bin/bash
# 定义mysql源码包的 .tar.gz 版本号
MYSQL8034_TARGZ='mysql-8.0.34.tar.gz'
MYSQL8034_TARGZ_MD5='2dafb5428d445d330625971213e4c6e4'

MYSQL8034_BOOST_TARGZ='mysql-boost-8.0.34.tar.gz'
MYSQL8034_BOOST_TARGZ_MD5='c8cfab52fbde1cca55accb3113c235eb'

LINUX_USER='work'
LINUX_PASSWORD='work'
innodb_buffer_pool_size
INNODB_BUFFER_POLL_SIZE=''

PACKAGES="libffi-devel wget gcc make zlib-devel openssl openssl-devel ncurses-devel openldap-devel gettext bzip2-devel xz-devel ncurses*"

function yum_install_packages() {
        # 将输入的软件包名称存储到数组中
        packages=("$@")

        installed=() # 存储已安装的软件包
        not_found=() # 存储不存在的软件包
        failed=()    # 存储安装失败的软件包

        for pkg in "${packages[@]}"; do
                if yum list installed "$pkg" >/dev/null 2>&1; then
                        installed+=("$pkg")
                        echo "$pkg already installed"
                else
                        if yum list available "$pkg" >/dev/null 2>&1; then
                                yum install -y "$pkg"
                                if [ $? -eq 0 ]; then
                                        installed+=("$pkg")
                                        echo "$pkg installed successfully"
                                else
                                        failed+=("$pkg")
                                        echo "$pkg installation failed"
                                fi
                        else
                                not_found+=("$pkg")
                                echo "$pkg not found in any repository"
                        fi
                fi
        done
        echo "=============================================="
        echo "Installed packages: ${installed[*]}"
        echo "Not found packages: ${not_found[*]}"
        echo "Failed packages: ${failed[*]}"
        echo "=============================================="

        if [ ${#installed[@]} -eq ${#packages[@]} ]; then
                return 0
        else
                #return 1
                exit 1
        fi
}

function prinf_require() {
        echo "GCC 7.1+"
        echo "make 3.75+"
        echo "Boost C++"
        echo "ncurses "
        echo "bison 2.1+ 尽可能使用最新版本的bison"
        echo "OpenSSL 1.0.1+"
        echo "/usr/local/mysql"
}

function repo() {
        echo ''

}

function dowload_mysql() {
        wget https://cdn.mysql.com//Downloads/MySQL-8.0/${MYSQL8034_BOOST_TARGZ}
        echo ''

}

function my_cnf_update() {
        if [ "$INNODB_BUFFER_POLL_SIZE" = '' ]; then
                INNODB_BUFFER_POLL_SIZE=1G
        fi

        #
        cat >/etc/my.cnf <<EOF

innodb_buffer_pool_size = "$INNODB_BUFFER_POLL_SIZE"
EOF
}

function mysql_install() {

        cmake -DBUILD_CONFIG=mysql_release -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$mysql_basedir -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_0900_ai_ci

}

function main() {
        yum_install_packages "$PACKAGES"
}

main
