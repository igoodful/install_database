#!/bin/bash
install_log='/tmp/mysql_install.log'
tmp_password=''
linux_user='work'
linux_password='work'

mysql_superuser="admin"
mysql_superuser_password=""

mysql_port=3306
mysql_basedir="/home/work/mysql_${mysql_port}"
mysql_datadir="${mysql_basedir}/data"

function create_user(){
	echo "create user ... "
	cat /etc/passwd  |awk -F':' '{print $1}' |grep "${linux_user}"
	if [ $? == 0 ]
	then 
		echo "$linux_user exists ..."
	else
		useradd ${linux_user}
		echo ${linux_user}:${linux_password}|chpasswd
	
	fi
	echo "create user done"

}

function create_mysql_dir(){
	mkdir -p ${mysql_basedir}
	mkdir -p {mysql_basedir}/{log,conf,tmp,}

}


function install_mysql(){
	${mysql_basedir}/bin/mysqld --initialize --user=${linux_user} --basedir=${mysql_basedir} --datadir=${mysql_basedir}/data  |tee -a ${install_log}
	tmp_password=$(cat {install_log} |grep 'root@localhost:' |awk -F'root@localhost: ' '{print $2}')

}


wget https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.40-linux-glibc2.12-x86_64.tar.gz
tar -xzvf mysql-5.7.40-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.40-linux-glibc2.12-x86_64  mysql-5.7.40


mv ${mysql_basedir}/support-files/mysql.server ${mysql_basedir}/bin
sed -i s/basedir=/basedir=${mysql_basedir}/g ${mysql_basedir}/bin/mysql.server
sed -i s/datadir=/datadir=${mysql_datadir}/g ${mysql_basedir}/bin/mysql.server



function main(){
	create_user()

}
