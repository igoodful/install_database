#!/bin/bash
linux_user='work'
redis_version='7.0.10'
redis_port=6381
redis_password='root'
redis_basedir="/home/work/redis_${redis_port}"
redis_datadir="${redis_basedir}/data"
redis_logdir="${redis_basedir}/log"
redis_confdir="${redis_basedir}/conf"
redis_tmpdir="${redis_basedir}/tmp"
redis_bindir="${redis_basedir}/bin"
mkdir -p ${redis_basedir}
mkdir -p ${redis_basedir}/{data,conf,log,tmp}

if [ -f "redis-${redis_version}.tar.gz" ]
then
	echo "redis-${redis_version}.tar.gz exists ..."
else
	wget https://download.redis.io/releases/redis-${redis_version}.tar.gz
fi

tar -xzvf  redis-${redis_version}.tar.gz
cd redis-${redis_version}
make 
make  PREFIX=${redis_basedir} install


cat >${redis_confdir}/redis.conf  <<EOF
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
${redis_bindir}/redis-server ${redis_confdir}/redis.conf  &

