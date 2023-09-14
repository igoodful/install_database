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


# 
function upgrade_kernel(){
wget 
wget 
wget
rpm -Uvh kernel-lt*.rpm
awk -F\' '$1=="menuentry " {print $2}' /etc/grub2.cfg
grub2-set-default 0
init 6
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
docker-engine
}





function main(){
# gcc gcc-c++ yum-utils device-mapper-persistent-data lvm2
yum_install_packages gcc gcc-c++ yum-utils device-mapper-persistent-data lvm2

}






[root@gip85 data]# systemctl list-units |grep 16315
  db-16315.service                                                                            loaded active running   mysql-16315 Server
[root@gip85 data]# ls
adm-dbinit  dbdata  docker  routerdata  svr  zkdata
[root@gip85 data]# systemctl list-units |grep 16309
  zk-16309.service                                                                            loaded active running   zk-16309 Server
[root@gip85 data]# systemctl list-units |grep 16310
  router-16310.service                                                                        loaded active exited    router-16310 Server
[root@gip85 data]# 


systemctl stop  adm-dbinit.service


/data/storage_path/backup_file/bin/recovery --config-file=/data/storage_path/backup_file/PHYSICAL_MODE/e58dba67-e88e-45c9-be65-21139e26f9d7/c6597ee6/recovery.conf >> /data/storage_path/backup_file/PHYSICAL_MODE/e58dba67-e88e-45c9-be65-21139e26f9d7/c6597ee6/out.log 2>&1 


socat -d -lf /data/restore/UTC20230906032532.918-full/socat_log/20230906/45696_10 -u tcp-listen:45696,reuseaddr file:/data/restore/UTC20230906032532.918-full/UTC20230906032532.918-full-new.tar,trunc,creat



select LOCAL from performance_schema.log_status\G


实际：1932788 gtid-54

记录：1932788 gtid-31


33fe7330-4321-11ee-bccd-00163e921763:1-583802

实际：6920  gtid-63:583802
记录：6920  gtid-63:583799



# rds恢复出来的

admin@127.0.0.1:16315[(none)]>show master status\G
*************************** 1. row ***************************
             File: greatdb-bin.000018
         Position: 1658
     Binlog_Do_DB: 
 Binlog_Ignore_DB: dbscale_tmp
Executed_Gtid_Set: 0bd5c549-4aea-11ee-b7c1-00163e8c6cf2:1-32,
0bd9869c-4aea-11ee-bbfb-00163ee6d0aa:1,
0bdb77bc-4aea-11ee-98fc-00163efbfe20:1-5,
232d29fc-4d1e-11ee-af69-00163ea45c99:1-4,
33fe7330-4321-11ee-bccd-00163e921763:1-1921505,
bb7c0b9c-4b8e-11ee-a8f9-00163ee3297e:1-8
1 row in set (0.00 sec)

# 17 log
# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#230907  9:17:12 server id 1358616315  end_log_pos 125  Start: binlog v 4, server v 8.0.26 created 230907  9:17:12
# at 125
#230907  9:17:12 server id 1358616315  end_log_pos 192  Previous-GTIDs
# 33fe7330-4321-11ee-bccd-00163e921763:1-1921063
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;



# 18 log
33fe7330-4321-11ee-bccd-00163e921763:1-1921063
SET @@SESSION.GTID_NEXT= '232d29fc-4d1e-11ee-af69-00163ea45c99:1'/*!*/;
SET @@SESSION.GTID_NEXT= '232d29fc-4d1e-11ee-af69-00163ea45c99:2'/*!*/;
SET @@SESSION.GTID_NEXT= '232d29fc-4d1e-11ee-af69-00163ea45c99:3'/*!*/;
SET @@SESSION.GTID_NEXT= '232d29fc-4d1e-11ee-af69-00163ea45c99:4'/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;

admin@127.0.0.1:16315[apple]>select * from  sbtest5 where id=53859;
+-------+------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
| id    | k    | c                                                                                                                       | pad                                                         |
+-------+------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
| 53859 | 7546 | 35409531466-81999834874-62276375681-06307348138-54175271716-24858799450-51526477786-59309218747-20524111113-37000360080 | 64597836736-00286034006-89943346789-40454537856-52539726444 |
+-------+------+-------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------+
1 row in set (0.00 sec)

### INSERT INTO `apple`.`sbtest5`
### SET
###   @1=53859 /* INT meta=0 nullable=0 is_null=0 */
###   @2=7546 /* INT meta=0 nullable=0 is_null=0 */
###   @3='35409531466-81999834874-62276375681-06307348138-54175271716-24858799450-51526477786-59309218747-20524111113-37000360080' /* STRING(480) meta=61152 nullable=0 is_null=0 */
###   @4='64597836736-00286034006-89943346789-40454537856-52539726444' /* STRING(240) meta=65264 nullable=0 is_null=0 */





# 实际的slave的binlog

33fe7330-4321-11ee-bccd-00163e921763:1-1921063

# master
33fe7330-4321-11ee-bccd-00163e921763:1-1891887
SET @@SESSION.GTID_NEXT= '33fe7330-4321-11ee-bccd-00163e921763:1921950










# 实际生产master
SET @@SESSION.GTID_NEXT= '33fe7330-4321-11ee-bccd-00163e921763:1921505'/*!*/;





SET @@SESSION.GTID_NEXT= '33fe7330-4321-11ee-bccd-00163e921763:1961916'/*!*/;
# at 321386646
#230907  1:22:34 server id 44049435  end_log_pos 321386718      Query   thread_id=248772        exec_time=0     error_code=0
SET TIMESTAMP=1694049754/*!*/;
BEGIN
/*!*/;
# at 321386718
#230907  1:22:34 server id 44049435  end_log_pos 321386783      Rows_query
# insert into ipad (id,name) values (null,1752)
# at 321386783
#230907  1:22:34 server id 44049435  end_log_pos 321386840      Table_map: `apple`.`ipad` mapped to number 169



# 直接回复出来：

            Executed_Gtid_Set: 0bd5c549-4aea-11ee-b7c1-00163e8c6cf2:1-32,
0bd9869c-4aea-11ee-bbfb-00163ee6d0aa:1,
0bdb77bc-4aea-11ee-98fc-00163efbfe20:1-5,
33fe7330-4321-11ee-bccd-00163e921763:1-1921063,
bb7c0b9c-4b8e-11ee-a8f9-00163ee3297e:1-8



--no-check-replication-filters --create-replicate-table --empty-replicate-table --recursion-method=processlist  --databases=


--tables=

pt-table-checksum h='172.17.135.83',u='admin',p='!QAZ2wsx',P=16315 --no-check-binlog-format --recursion-method=hosts --check-replication-filters --create-replicate-table --nocheck-replication-filters --databases=apple





# unknown variable ‘default-character-set=utf8’
--no-defaults



mysqlbinlog --no-defaults   binlog.000068 --start-position=815 --stop-position=1026  | mysql -uroot -p123456 -h127.0.0.1 -P3333



--start-datetime="2020-03-20 10:00:00" --stop-datetime="2020-03-21 10:00:00" mysql-bin.000001 -d database_name> filename_binlog.sql





# 一般不用 source filename_binlog.sql












```

