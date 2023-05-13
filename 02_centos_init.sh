#!/bin/bash
init_time=$(date '+%Y%m%d%H%M%S')
systemctl set-default multi-user.target

function yum_update() {
	if [ -f /etc/yum.repos.d/proxysql.repo ]; then
		echo "exits"
	else
		cat >/etc/yum.repos.d/proxysql.repo <<EOF
[proxysql]
name=ProxySQL YUM repository
baseurl=https://repo.proxysql.com/ProxySQL/proxysql-2.4.x/centos/\$releasever
gpgcheck=1
gpgkey=https://repo.proxysql.com/ProxySQL/proxysql-2.4.x/repo_pub_key
EOF
	fi
	yum -y update

	yum -y install epel-release
	yum -y install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
	yum -y erase mariadb mariadb-server mariadb-libs mariadb-devel
	yum clean all
	yum makecache

}

function git_upgrade() {
	yum -y remove git
	rpm -ivh http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm
	yum -y install git
	git --version
	if [ $? -ne 0 ]; then
		echo "git install error"
		exit 1
	fi
	git config --global user.name "igoodful"
	git config --global user.email "igoodful@qq.com"
	git config --global init.defaultBranch main
}

function firewalld_stop() {
	echo "firewalld_stop ..."
	systemctl status firewalld
	systemctl stop firewalld
	systemctl disable firewalld

}

function selinux_stop() {
	echo "selinux_stop ..."
	if sestatus | grep -q "disabled"; then
		echo "SELinux is off"
	else
		setenforce 0
	fi

	if sestatus | grep -q "disabled"; then
		echo "SELinux is off"
		sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
	else
		echo "SELinux 关闭失败"
		echo "请单独检查"
		sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config
	fi

}

function sysctl_conf_update() {
	cp /etc/sysctl.conf /etc/sysctl.conf.${init_time}
	cat >/etc/sysctl.conf <<EOF
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
vm.overcommit_memory = 1
EOF

	sysctl -p

}

function limits_conf_update() {
	echo "limits_conf_update"
	cp /etc/security/limits.conf /etc/security/limits.conf.${init_time}
	cat >/etc/security/limits.conf <<EOF
* soft    nofile  1024000
* hard    nofile  1024000
* soft    nproc   unlimited
* hard    nproc   unlimited
* soft    core    unlimited
* hard    core    unlimited
* soft    memlock unlimited
* hard    memlock unlimited
EOF
	cat /etc/security/limits.conf
}

function somaxconn_update() {
	echo "2048" >/proc/sys/net/core/somaxconn
}

function rc_local_update() {
	sed -i '/^$/d' /etc/rc.local
	sed -i '/^#/d' /etc/rc.local
	sed -i '/transparent_hugepage/d' /etc/rc.local
	cat >>/etc/rc.local <<EOF
echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
EOF
	source /etc/rc.local
}

function update_profile(){
sed -i '/LANG/d' /etc/profile
echo 'LANG=en_US.UTF-8' >>/etc/profile
source /etc/profile
}

function date_update() {
	date -R | grep '+0800'
	if [ $? == 0 ]; then
		echo ""
	else
		echo ""
	fi

}

function ntpd_start() {
	echo ""

}

function keepalived_install() {
	yum -y install kernel-devel openssl-devel popt-devel libnfnetlink-devel libnl libnl-devel
	# xiazaikeepalived-1.4.4.tar.gz
	tar zxvf keepalived-1.4.4.tar.gz
	cd keepalived-1.4.4
	./configure --prefix=/usr/local/keepalived/ --sysconf=/etc
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

function main() {
	yum_update
	git_upgrade
	firewalld_stop
	selinux_stop
	sysctl_conf_update
	limits_conf_update
	somaxconn_update
	rc_local_update
	date_update

}
if [ "$1" == '-p' ]; then
	echo "cmake version list: "
	curl https://cmake.org/files/ 2>&1 | grep 'href=' | awk -F'"' '{print $8}' | grep '^v' | grep -v vCVS | awk -F'/' '{print $1}'
else
	main
fi
