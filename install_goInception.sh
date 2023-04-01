#!/bin/bash
linux_user='work'
goInception_host="0.0.0.0"
goInception_port=4000
backup_host = "mysql_ip"
backup_port = mysql_port
backup_user = "mysql_user"
backup_password = "mysql_password"

goInception_basedir="${linux_user}/goInception"
goInception_bindir="${goInception_basedir}/bin"
goInception_confir="${goInception_basedir}/conf"
goInception_logdir="${goInception_basedir}/log"

mkdir -p ${goInception_basedir}
mkdir ${goInception_bindir}
mkdir ${goInception_confdir}
mkdir ${goInception_logdir}


git clone https://github.com/hanchuanchuan/goInception.git
cd goInception
go build -o goInception tidb-server/main.go

cp -r config/config.toml.default config/config.toml	
cp goInception ${goInception_bindir}
cp config/config.toml.default ${goInception_confdir}/config.toml
sed -i /host/d ${goInception_confdir}/config.toml
sed -i /port/d ${goInception_confdir}/config.toml



${goInception_bindir}/goInception --config=${goInception_confdir}/config.toml &





