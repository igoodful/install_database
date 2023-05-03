#!/bin/bash
init_time=$(date '+%Y%m%d%H%M%S')
packages="perl-ExtUtils-MakeMaker perl-CPAN"


function yum_update(){
	yum clean all
	yum makecache
	yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
	yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
	yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
	yum -y erase mariadb mariadb-server mariadb-libs mariadb-devel


}

function firewalld_stop(){
	echo "firewalld_stop ..."
	systemctl status firewalld
	systemctl stop firewalld
	systemctl disable firewalld


}

function selinux_stop(){
	echo "selinux_stop ..."
	if sestatus |grep -q "disabled";then
		echo "SELinux is off"
	else
		setenforce 0
	fi

	if sestatus |grep -q "disabled";then
		echo "SELinux is off"
		sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
	else
		echo "SELinux 关闭失败"
		echo "请单独检查"
	fi


}

function sysctl_conf_update(){
	cp /etc/sysctl.conf /etc/sysctl.conf.${init_time}
	cat > /etc/sysctl.conf << EOF
vm.swappiness=10
# 开启IP虚拟转发
net.ipv4.ip_nonlocal_bind=1
net.ipv4.ip_forward=1
fs.aio-max-nr = 1048576
fs.file-max = 6815744
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048586
net.core.somaxconn=3276
kernel.sem = 500 64000 100 128
EOF

sysctl -p

}

function limits_conf_update(){
echo "limits_conf_update"
	cp /etc/security/limits.conf /etc/security/limits.conf.${init_time}
	sed -i '/^soft.*nofile/d' /etc/security/limits.conf
	sed -i '/^soft.*nproc/d' /etc/security/limits.conf
	sed -i '/^hard.*nofile/d' /etc/security/limits.conf
	sed -i '/^hard.*nproc/d' /etc/security/limits.conf
	cat >> /etc/security/limits.conf << EOF
soft nofile 204800
hard nofile 204800
soft nproc 204800
hard nproc 204800
EOF
sed -i '/^$/d' /etc/security/limits.conf
sed -i '/^#/d' /etc/security/limits.conf
cat /etc/security/limits.conf
}

function date_update(){
	date -R |grep '+0800'
	if [ $? == 0  ];then
		echo ""
	else
echo ""
	fi

}

function ntpd_start(){
echo ""

}

function keepalived_install(){
yum -y install kernel-devel openssl-devel popt-devel libnfnetlink-devel libnl libnl-devel 
# xiazaikeepalived-1.4.4.tar.gz
tar zxvf keepalived-1.4.4.tar.gz
cd keepalived-1.4.4
./configure --prefix=/usr/local/keepalived/   --sysconf=/etc
make && make install
#centos 7 注册系统服务并启动keepalived
systemctl daemon-reload
systemctl start keepalived ##暂时不要启动
systemctl enable keepalived
#配置开机启动
chkconfig --add keepalived
chkconfig --level 345 keepalived on
service keepalived start
##配置注释KillMode=process进程:KillMode=process #表示只杀掉程序的主进程，打开的子进程不管。我们keepalived肯定要全部杀掉。所以注释掉这一行。
sed -i '/KillMode/d' /lib/systemd/system/keepalived.service  
}



function main(){
yum_update
firewalld_stop
selinux_stop
sysctl_conf_update
limits_conf_update
date_update

}

main

