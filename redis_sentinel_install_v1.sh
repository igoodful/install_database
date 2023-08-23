#!/bin/bash
interface=eth0
netmask=24
redis_password='root'
redis_port=26379
redis_basedir=/home/work/redis_$redis_port
redis_datadir=/home/work/redis_$redis_port/data
redis_confdir=/home/work/redis_$redis_port/conf
redis_bindir=/home/work/redis_$redis_port/bin
redis_logdir=/home/work/redis_$redis_port/log
redis_tmpdir=/home/work/redis_$redis_port/tmp

dir_add() {
        echo 'dd'

}

ip addr add ${VIP}/${NETMASK} dev ${INTERFACE}
# rpm -ivh tcl-8.5.13-8.el7.x86_64.rpm
yum -y install tcl

redis_install() {
        make PREFIX=$redis_basedir install
        make test
}

conf_update() {
        cat >sentinel <<EOF
port 26379
bind 0.0.0.0
daemonize yes
logfile "${redis_logdir}/redis.log"
dir "${redis_datadir}/data"
sentinel myid 6072a5a2e901e345tf6d6987d1a305e8ab1f5c8a
sentinel deny-scripts-reconfig yes
sentinel monitor mymaster 192.168.1.203 6379 2
sentinel down-after-milliseconds mymaster 20000
sentinel auth-pass mymaster root
EOF
        echo ""
}
