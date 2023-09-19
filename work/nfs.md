







```bash
# 服务端
yum -y install rpcbind nfs-utils
mkdir /data/share/
chmod 755 -R /data/share/
echo "/data/share/ *(rw,no_root_squash,no_all_squash,sync)" > /etc/exports
systemctl start rpcbind
systemctl start nfs
systemctl enable rpcbind 
systemctl enable nfs
showmount -e localhost

# 客户端
yum -y install rpcbind nfs-utils
showmount
mkdir -p /mnt/share
mount -t nfs 172.17.135.193:/data/redis /root/glc/redis -o nolock,nfsvers=3,vers=3
umount /mnt/share
echo "mount -t nfs 192.168.11.34:/data/share /mnt/share/ -o nolock,nfsvers=3,vers=3" >> /etc/rc.d/rc.local



```

