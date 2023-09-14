























```shell
################################ vim /usr/lib/systemd/system/router-3307.service
[Unit]
Description=ADM router-3307 Server
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
User=mysql
Group=mysql
WorkingDirectory=/greatdb_data/routerdata/3307
Type=forking
ExecStart=/greatdb_data/routerdata/3307/daemon/dbscale_daemon.py
ExecStop=/greatdb_data/routerdata/3307/daemon/stopper.sh
Restart=on-failure
LimitNOFILE=1024000
LimitNPROC=1024000
TimeoutStopSec=15
PrivateTmp=false
RemainAfterExit=yes


###################################### vim /usr/lib/systemd/system/db-3308.service
[Unit]
Description=ADM mysql-3308 Server
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
User=mysql
Group=mysql

Type=simple
ExecStart=/greatdb_data/svr/MySQLPackage-8.0.26-Linux-glibc2.12-x86_64/mysql/bin/mysqld_safe --defaults-file=/greatdb_data/dbdata/3308/my3308.cnf --user=mysql
Restart=on-failure
LimitNOFILE=1024000
LimitNPROC=1024000
TimeoutStopSec=15
PrivateTmp=false
################# vim /usr/lib/systemd/system/zk-3309.service
[Unit]
Description=ADM zk-3309 Server
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
User=mysql
Group=mysql

Type=forking
Environment="JAVA_HOME=/greatdb_data/svr/MySQLPackage-8.0.26-Linux-glibc2.12-x86_64/java"
Environment="JRE_HOME=${JAVA_HOME}/jre"
Environment="CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib"
Environment="PATH=${JAVA_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ExecStart=/greatdb_data/zkdata/3309/bin/zkServer.sh start
ExecStop=/greatdb_data/zkdata/3309/bin/zkServer.sh stop

Restart=on-failure
LimitNOFILE=1024000
LimitNPROC=1024000
TimeoutStopSec=15
PrivateTmp=false
######################################


























```

