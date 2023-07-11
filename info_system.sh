#!/bin/bash
echo "centos    version: $(cat /etc/redhat-release |awk '{print $4}')"
echo "arch         type: $(file /bin/bash |awk -F',' '{print $2}')"
echo "cpu         cores: $(cat /proc/cpuinfo |grep processor |wc -l)"
echo "mem        sizeGB: $(free -h |grep Mem |awk '{print $2}')"
echo "swap       sizeGB: $(free -h |grep Swap |awk '{print $2}')"
echo "glibc     version: $(ldd --version |grep GNU |awk '{print $4}')"
echo "libgcrypt version: $(rpm -qa|grep libgcrypt|grep -v devel)"
echo "gcc       version: $(gcc --version |grep GCC|awk '{print $3}')"
echo "git       version: $(git --version |awk '{print $3}')"
echo "cmake     version: $(cmake --version|grep version|awk '{print $3}')"
echo "make      version: $(make --version |grep GNU |grep Make|awk '{print $3}')"
echo "bison     version: $(bison --version |grep GNU |awk '{print $4}')"
echo "openssl   version: $(openssl version|awk '{print $2}')"
echo "git       version: $()"
echo "git       version: $()"


df -Th





