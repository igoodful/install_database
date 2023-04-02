#!/bin/bash
init_time=$(date '+%Y%m%d%H%M%S')



function yum_update(){
	yum clean all
	yum makecache


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
		exit 1
	fi


}

function sysctl_conf_update(){
	cp /etc/sysctl.conf /etc/sysctl.conf.${init_time}
	sed -i '/vm.swappiness/d'
	sed -i '/fs.aio-max-nr/d'
	sed -i '/s.file-max/d'
	sed -i '/net.ipv4.ip_local_port_range/d'
	sed -i '/et.core.rmem_default/d'
	sed -i '/net.core.rmem_max/d'
	sed -i '/net.core.wmem_default/d'
	sed -i '/net.core.wmem_max/d'
	sed -i '/net.core.somaxconn/d'
	sed -i '/kernel.sem/d'
	cat >> /etc/sysctl.conf << EOF
vm.swappiness=10
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
sed -i '/^$/d' /etc/sysctl.conf

sysctl -p

}

function limits_conf_update(){
	cat /etc/security/limits.conf /etc/security/limits.conf.${init_time}
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

}

function date_update(){
	date -R |grep '+0800'
	if [ $? == 0  ];then
		echo ""
	else

	fi

}

function ntpd_start(){


}


function main(){


}

main

