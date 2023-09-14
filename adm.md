







```shell
/greatdb_data/svr/MySQLPackage-8.0.26-Linux-glibc2.12-x86_64/tools/percona-xtrabackup/bin/xtrabackup  --defaults-file=/greatdb_data/dbdata/3308/my3308.cnf --login-path=xtrlogin  --user=admin --password='!QAZ2wsx'  --host=172.17.135.195 --port=3308 --backup    --extra-lsndir=/greatdb_data/dbdata/3308/tmp/lsn --tmpdir=/greatdb_data/dbdata/3308/tmp  --stream=xbstream 2> /greatdb_data/dbdata/3308/tmp/172.17.135.195_3308_full.log | gzip  > /mysql_storage/data/backup_router/nb/3308/172.17.135.195-3308-20230908145734_full.xbstream.gz 


/greatdb_data/svr/MySQLPackage-8.0.26-Linux-glibc2.12-x86_64/tools/percona-xtrabackup/bin/xtrabackup --defaults-file=/greatdb_data/dbdata/3308/my3308.cnf --login-path=xtrlogin --user=admin --password=x xxxxxx --host=172.17.135.196 --port=3308 --backup --compress --compress-threads=2 --extra-lsndir=/greatdb_data/dbdata/3308/tmp/lsn --tmpdir=/greatdb_data/dbdata/3308/tmp --stream=xbstream


/greatdb_data/svr/MySQLPackage-8.0.26-Linux-glibc2.12-x86_64/tools/percona-xtrabackup/bin/xtrabackup  --defaults-file=/greatdb_data/dbdata/3308/my3308.cnf --login-path=xtrlogin  --user=admin --password='!QAZ2wsx'  --host=172.17.135.196 --port=3308 --backup  --compress --compress-threads=2 --extra-lsndir=/greatdb_data/dbdata/3308/tmp/lsn --tmpdir=/greatdb_data/dbdata/3308/tmp  --stream=xbstream 2> /greatdb_data/dbdata/3308/tmp/172.17.135.196_3308_full.log | gzip  > /mysql_storage/data/backup_router/nb/3308/172.17.135.196-3308-20230908151513_full.xbstream.gz 



rpm -ivh libev-4.15-1.el6.rf.x86_64.rpm
yum install perl-DBI
yum -y install perl perl-devel libaio libaio-devel perl-Time-HiRes perl-DBD-MySQL
yum -y install perl-Digest-MD5
sudo yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm
sudo yum -y install qpress

xtrabackup --decompress --target-dir=/data/backupset/backup_router/nb/3308/2023-09-08/data
xtrabackup --prepare    --target-dir=/data/backupset/backup_router/nb/3308/2023-09-08/data
find . -type f -name "*.qp" -delete

# gzip 不能压缩目录，只能压缩文件。
gzip install.log
gzip -c anaconda-ks.cfg >anaconda-ks.cfg.gz
# gzip -r test/
# 原来gzip命令不会打包目录，而是把目录下所有的子文件分别压缩
# 备份

kubeadm init --kubernetes-version=1.28.1 \
                --apiserver-advertise-address=172.17.135.196 \
                --pod-network-cidr=10.244.0.0/16 \
                --cri-socket unix:///var/run/containerd/containerd.sock
kubeadm init --image-repository=registry.aliyuncs.com/google_containers --pod-network-cidr=10.244.0.0/16 --kubernetes-version=v1.28.1 --apiserver-advertise-address=172.17.135.196 

kubeadm reset
rm -rf $HOME/.kube




/etc/containerd/config.toml

[plugins."io.containerd.grpc.v1.cri".registry]
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."harbor.com"]
          endpoint = ["http://harbor.com"]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."192.168.1.80:5000"]
          endpoint = ["http://192.168.1.80:5000"]


v1.20以上版本默认使用containerd作为引擎，不再使用docker。

单纯的配置 /etc/docker/daemon.json 或者/usr/lib/systemd/sysem/docker.service 来pull http的镜像仓库时还是会提示 http server gave http response to https client

# 所有节点需要修改containerd的配置文件/etc/containerd/config.toml


/var/lib/kubelet




```

