```shell
#!/bin/bash

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


function 




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

function swap_off(){
echo '---- swap_off staring...'
free -h
swapoff -a
sed -ri 's/.*swap.*/#&/' /etc/fstab
free -h
echo '---- swap_off end'
}


function remove_docker(){
yum	remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-engine \
docker-ce \
docker-ce-cli \
containerd.io
rm -rf /var/lib/docker
rm -rf /var/lib/containerd
}





function main(){
# gcc gcc-c++ yum-utils device-mapper-persistent-data lvm2
yum_install_packages gcc gcc-c++ yum-utils device-mapper-persistent-data lvm2

}







{
 "registry-mirrors" : [
 "registry.cn-hangzhou.aliyuncs.com",
   "https://mirror.ccs.tencentyun.com",
   "http://registry.docker-cn.com",
   "http://docker.mirrors.ustc.edu.cn",
   "http://hub-mirror.c.163.com"
 ],
 "insecure-registries" : [
   "registry.docker-cn.com",
   "docker.mirrors.ustc.edu.cn"
 ],
 "debug" : true,
 "experimental" : true
}


{
    "registry-mirrors":[
        "https://ctgpt0yh.mirror.aliyuncs.com"
    ],
    "insecure-registries":[
        "registry.myq.com"
    ],
    "exec-opts":[
        "native.cgroupdriver=systemd"
    ]
}

kubeadm config images list

```
