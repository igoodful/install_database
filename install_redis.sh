#!/bin/bash

linux_user='work'
redis_version='6.0.12'
redis_port=6381
redis_password='root'
package="wget make gcc gcc-c++ zlib-devel openssl openssl-devel pcre-devel kernel keyutils  patch perl tcl"

redis_basedir="/home/work/redis_${redis_port}"
redis_datadir="${redis_basedir}/data"
redis_logdir="${redis_basedir}/log"
redis_confdir="${redis_basedir}/conf"
redis_tmpdir="${redis_basedir}/tmp"
redis_bindir="${redis_basedir}/bin"


function yum_install_packages() {
    # 将输入的软件包名称存储到数组中
    packages=("$@")

    installed=() # 存储已安装的软件包
    not_found=() # 存储不存在的软件包
    failed=()    # 存储安装失败的软件包

    for pkg in "${packages[@]}"
    do
        if yum list installed "$pkg" > /dev/null 2>&1; then
            installed+=("$pkg")
            echo "$pkg already installed"
        else
            if yum list available "$pkg" > /dev/null 2>&1; then
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



function install_redis() {
    mkdir -p ${redis_basedir}/{data,conf,log,tmp}
    if [ -f "redis-${redis_version}.tar.gz" ]; then
        echo "redis-${redis_version}.tar.gz exists ..."
    else
        wget https://download.redis.io/releases/redis-${redis_version}.tar.gz
    fi
    tar -xzvf redis-${redis_version}.tar.gz
    cd redis-${redis_version}
    make
    echo "======================================="
    echo "make install"
    make PREFIX=${redis_basedir} install
    make test |grep 'All tests passed without errors!'
}

function config_redis() {
    cat > ${redis_confdir}/redis.conf <<EOF
daemonize yes
pidfile ${redis_tmpdir}
port ${redis_port}
timeout 0
loglevel notice
logfile ${redis_logdir}/redis.log
databases 16
save 900 1
save 300 10
save 60 10000
rdbcompression yes
dbfilename dump.rdb
dir ${redis_datadir}
slave-serve-stale-data yes
slave-read-only yes
repl-disable-tcp-nodelay no
slave-priority 100
requirepass ${redis_password}
maxmemory 10737418240
appendonly no
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
lua-time-limit 5000
slowlog-log-slower-than 10000
slowlog-max-len 128
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
list-max-ziplist-entries 512
list-max-ziplist-value 64
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
activerehashing yes
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit slave 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
hz 10
aof-rewrite-incremental-fsync yes
EOF
    chown -R ${linux_user}:${linux_user} ${redis_basedir}
}

function start_redis() {
    ${redis_bindir}/redis-server ${redis_confdir}/redis.conf &
    echo "${redis_bindir}/redis-server ${redis_confdir}/redis.conf &" >${redis_basedir}/start.sh
    chmod a+x ${redis_basedir}/start.sh
}

function main() {
    yum_install_packages $package
    install_redis
    config_redis
    start_redis
}

main

