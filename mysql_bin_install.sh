#!/bin/bash
echo "GCC 7.1+"
echo "make 3.75+"
echo "Boost C++"
echo "ncurses "
echo "bison 2.1+ 尽可能使用最新版本的bison"
echo " OpenSSL 1.0.1+"
echo "/usr/local/mysql"

soft_dir='/home/work/tmp'
install_time=$(date  '+%Y%m%d%H%M%S')
install_log="${soft_dir}/${install_time}.log"
tmp_password=''
linux_user='work'
linux_password='work'

mysql_version='8.0.25'
mysql_main_version="8.0"
mysql_glibc_version='2.17'
linux_arch='x86_64'
mysql_name_dir="mysql-${mysql_version}-linux-glibc${mysql_glibc_version}-${linux_arch}"
mysql_targz_name="${mysql_name_dir}.tar.gz"
# for example mysql-5.7.40-linux-glibc2.12-x86_64.tar.gz





echo "mysql-5.7.40-linux-glibc2.12-x86_64.tar.gz"
echo "$mysql_targz_name"
mysql_md5='ce0ef7b9712597f44f4ce9b9d7414a24'
packages="libffi-devel wget gcc make zlib-devel openssl openssl-devel ncurses-devel openldap-devel gettext bzip2-devel xz-devel ncurses*"

mysql_superuser="admin"
mysql_superuser_password="admin"
mysql_port=3307

mysql_base_dir="/home/work/mysql_${mysql_port}"
mysql_base_dir_sed=$(echo ${mysql_base_dir} | sed 's/\//\\\//g')

mysql_data_dir="${mysql_base_dir}/data"
mysql_data_dir_sed=$(echo ${mysql_data_dir} | sed 's/\//\\\//g')

mysql_bin_dir="${mysql_base_dir}/bin"
mysql_conf_dir="${mysql_base_dir}/conf"

mysql_log_dir="${mysql_base_dir}/log"
mysql_log_dir_sed=$(echo ${mysql_log_dir} | sed 's/\//\\\//g')

mysql_tmp_dir="${mysql_base_dir}/tmp"
mysql_tmp_dir_sed=$(echo ${mysql_tmp_dir} | sed 's/\//\\\//g')

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



function user_add(){
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

function dir_add(){
	mkdir -p ${mysql_base_dir}
	mkdir -p ${mysql_base_dir}/{log,conf,tmp,data}
	mkdir -p ${soft_dir}
	cd ${soft_dir}

}


function mysql_download(){
	cd ${soft_dir}
	if [ -f "${soft_dir}/${mysql_targz_name}" ]
	then
		echo "${soft_dir}/${mysql_targz_name}   exists ..."	
		md5_tmp=$(md5sum ${soft_dir}/${mysql_targz_name} |awk '{print $1}')
		if [ "$md5_tmp" == "$mysql_md5" ]
		then
			echo "download is done ..."
		else
			mv ${soft_dir}/mysql-${mysql_version}.tar.gz ${soft_dir}/mysql-${mysql_version}.tar.gz.$install_time
			echo "${soft_dir}/${mysql_targz_name} is bad"
			exit 2
		fi
	else
		echo "download starting ...>>>https://cdn.mysql.com/archives/mysql-8.0/mysql-boost-8.0.25.tar.gz"
		wget -O mysql-8.0.25.tar.gz https://cdn.mysql.com/archives/mysql-8.0/mysql-boost-8.0.25.tar.gz

	fi
	echo "mysql_download is done"
}



function mysql_install(){
	echo " is mysqld --initialize   ;but is not mysqld --initialize-insecure"
	cd ${soft_dir}
	tar -xzvf ${mysql_targz_name}
	mv ${mysql_name_dir}/* ${mysql_base_dir}/
	${mysql_base_dir}/bin/mysqld --initialize --user=${linux_user} --basedir=${mysql_base_dir} --datadir=${mysql_base_dir}/data >> ${install_log} 2>&1
	tmp_password=$(cat ${install_log} |grep 'root@localhost:' |awk -F'root@localhost: ' '{print $2}')
	echo "tmp_password is :${tmp_password}"

}

function my_cnf_update(){
	echo "my_cnf_update  is running ..."
	mem_total=$(free  |grep Mem |awk '{print $2}')
	tmp_table_size=mem_total*0.2
	max_heap_table_size=$tmp_table_size
	cat > ${mysql_conf_dir}/my.cnf << EOF
[client]
port = ${mysql_port}
socket = ${mysql_tmp_dir}/mysql.sock

[mysqld]
user = ${linux_user}
port = ${mysql_port}

basedir = ${mysql_base_dir}
datadir = ${mysql_data_dir}
tmpdir = ${mysql_tmp_dir}
socket = ${mysql_tmp_dir}/mysql.sock
pid_file = ${mysql_tmp_dir}/mysql.pid
log-error = ${mysql_log_dir}/log.error
general_log = ${mysql_log_dir}/log.general
slow_query_log_file = ${mysql_log_dir}/log.slow
log-bin = ${mysql_log_dir}/mysql-bin
plugin_dir = ${mysql_base_dir}/lib/plugin

default-time-zone = "+08:00"
performance_schema = 1
log_slave_updates
log_timestamps = SYSTEM
log_warnings
slow_query_log
long_query_time = 0.5
lock_wait_timeout = 120
show_compatibility_56 = on
sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
table_open_cache_instances = 16

optimizer_switch='index_merge=on,index_merge_union=on,index_merge_sort_union=on,index_merge_intersection=on,engine_condition_pushdown=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=on,block_nested_loop=on,batched_key_access=off,materialization=on,semijoin=on,loosescan=on,firstmatch=on,subquery_materialization_cost_based=on,use_index_extensions=on'
super_read_only = off
log_slow_slave_statements = on
log_slow_admin_statements = on

event-scheduler = off
back_log = 1000
skip_name_resolve
max_connections = 10240
max_user_connections = 4000
max_connect_errors = 1000

table_open_cache = 8192
table_definition_cache = 65535
max_allowed_packet = 64M
expire_logs_days = 7
max_heap_table_size = 1024M
read_rnd_buffer_size = 512K
group_concat_max_len = 1024000
sort_buffer_size = 256K
read_buffer_size = 64K
join_buffer_size = 128K
thread_cache_size = 256
ft_min_word_len = 4
default-storage-engine = INNODB
thread_stack = 192K
transaction_isolation = REPEATABLE-READ
tmp_table_size = 1024M
open_files_limit = 65536
key_buffer_size = 32M
bulk_insert_buffer_size = 64M
myisam_sort_buffer_size = 128M
myisam_max_sort_file_size = 1G
#myisam_repair_threads = 1
max_allowed_packet = 64M
max_prepared_stmt_count = 1000000

#replication
server-id = 4545454545
binlog_rows_query_log_events = on
log-slave-updates = 1
relay-log = relay-bin
#这个参数一般用在主主同步中，用来错开自增值, 防止键值冲突
#auto_increment_offset = 1
#这个参数一般用在主主同步中，用来错开自增值, 防止键值冲突
# auto_increment_increment = 1
#####################必须集群内互相兼容，建议全都保持一致并为 row
binlog_format = row

binlog_checksum = none

binlog_cache_size = 16M
max_binlog_cache_size = 2G
sync_binlog = 1
master_info_repository = TABLE
relay_log_info_repository = TABLE
relay_log_recovery = on
sync_master_info = 10000
sync_relay_log_info = 10000
sync_relay_log = 0
#slave_net_timeout = 4
#slave-parallel-type = LOGICAL_CLOCK
#slave-parallel-workers = 16
slave_pending_jobs_size_max = 134217728
slave_preserve_commit_order = 0

#################################

#transaction_write_set_extraction = XXHASH64
#binlog_transaction_dependency_tracking = WRITESET

#slave_net_timeout=8
###############mysql版本在5.6之后才有该选项。
gtid_mode = on
###############mysql版本在5.6之后才有该选项。
enforce-gtid-consistency = on
#
##############################################################################################半同步复制插件，需要安装。mysql5.7版本之后才有。
##########################################。安装插件在主库上：install plugin rpl_semi_sync_master soname 'semisync_master.so'; --安装 semisync_master.so插件
##########################################。安装插件在从库上：install plugin rpl_semi_sync_slave soname 'semisync_slave.so'; --安装 semisync_slave.so插件
#plugin_load = "rpl_semi_sync_master=semisync_master.so;rpl_semi_sync_slave=semisync_slave.so"
################################半同步复制插件，需要安装。mysql5.7版本之后才有。
#rpl_semi_sync_master_enabled = on
################################半同步复制插件，需要安装。mysql5.7版本之后才有。
#rpl_semi_sync_slave_enabled = on
################################半同步复制插件，需要安装。mysql5.7版本之后才有。
#rpl_semi_sync_master_wait_for_slave_count = 1
################################半同步复制插件，需要安装。mysql5.7版本之后才有。
#rpl_semi_sync_master_timeout = 1000
################################半同步复制插件，需要安装。mysql5.7版本之后才有。
#rpl_semi_sync_master_wait_point = after_sync


#undo
innodb_max_undo_log_size = 1024M
innodb_undo_log_truncate = on
innodb_undo_logs = 128
#innodb_undo_tablespaces = 3 #只能在初始化的时候设置
innodb_purge_rseg_truncate_frequency = 128

#innodb
innodb_autoextend_increment = 64
innodb_concurrency_tickets = 5000
innodb_old_blocks_time = 1000
innodb_purge_batch_size = 300
innodb_stats_on_metadata = off
innodb_thread_sleep_delay = 10000
innodb_adaptive_max_sleep_delay = 15000
innodb_buffer_pool_dump_at_shutdown = on
innodb_buffer_pool_load_at_startup = on
innodb_flush_neighbors = 1
############################nnoDB使用后台线程处理数据页上写 I/O（输入）请求的数量。
innodb_write_io_threads = 8
############################InnoDB使用后台线程处理数据页上读 I/O（输出）请求的数量。这里输出是输入的两倍。
innodb_read_io_threads = 16
innodb_print_all_deadlocks = on
innodb_buffer_pool_size = 1G
innodb_buffer_pool_instances = 8
#innodb_data_file_path = ibdata1:100M:autoextend # 这个参数在windows版本上没有这个参数
innodb_thread_concurrency = 48
innodb_flush_log_at_trx_commit = 1
innodb_log_buffer_size = 64M
innodb_log_file_size = 4096M
innodb_log_files_in_group = 3
###############################控制了 Dirty Page 在 Buffer Pool 中所占的比率。
innodb_max_dirty_pages_pct = 75
innodb_max_dirty_pages_pct_lwm = 10
innodb_flush_method = O_DIRECT # 在windows上不行
innodb_lock_wait_timeout = 10
#innodb_file_per_table参数必须设置为1，否则xtrabackup工具无法单独备份某一个数据库。
innodb_file_per_table = 1
innodb_purge_threads = 4

innodb_io_capacity = 5000
innodb_open_files = 65535
innodb_online_alter_log_max_size = 5120M
innodb_sort_buffer_size = 4M
innodb_adaptive_hash_index_parts = 8
innodb_buffer_pool_chunk_size = 128
innodb_buffer_pool_dump_pct = 80
innodb_deadlock_detect = on
innodb_default_row_format = DYNAMIC
innodb_fill_factor = 100
innodb_flush_sync = off
innodb_log_checksums = on
innodb_log_write_ahead_size = 8192
innodb_max_undo_log_size = 1073741824
innodb_page_cleaners = 4
innodb_purge_rseg_truncate_frequency = 128
innodb_temp_data_file_path = ibtmp1:12M:autoextend
#innodb_print_lock_wait_timeout_info = on

EOF

}

function mysql_server_update(){
	echo "mysql_server_update is running ..."
	mv ${mysql_base_dir}/support-files/mysql.server ${mysql_base_dir}/bin
	cp ${mysql_base_dir}/bin/mysql.server ${mysql_base_dir}/bin/${install_time}.mysql.server.${install_time}
	sed -i s/^basedir=.*/basedir=${mysql_base_dir_sed}/g ${mysql_base_dir}/bin/mysql.server
	sed -i s/^datadir=.*/datadir=${mysql_data_dir_sed}/g ${mysql_base_dir}/bin/mysql.server

	echo "mysql_server_update is done"
}

function mysql_start(){
	chown -R ${linux_user}:${linux_user} ${mysql_base_dir}
	echo "mysql_start is running ..."
	su - ${linux_user}
	${mysql_bin_dir}/mysqld --defaults-file=${mysql_conf_dir}/my.cnf &
	ps aux|grep mysqld
	if [ "$?" == 0 ]
	then
		echo "mysql start success "
	else
		echo "mysql start failed "
		exit 1
	fi
}

function mysql_init(){
	echo "mysql_init is running ..."
	sleep 30
	ls -l ${mysql_tmp_dir}
	sleep 30
	ls -l ${mysql_tmp_dir}
	sleep 30
	ls -l ${mysql_tmp_dir}
	sleep 30
	while true
	do
		ls -l ${mysql_tmp_dir} |grep 'mysql.sock'
		if [ $? == 0 ]
		then
			break
		fi
		sleep 5
	done

	echo $tmp_password
	if [ -e "${mysql_tmp_dir}/mysql.sock" ]
	then
		tmp_password="'${tmp_password}'"
		echo "${mysql_bin_dir}/mysql -e -uroot -P${mysql_port}  -S  ${mysql_tmp_dir}/mysql.sock -p${tmp_password}"
		${mysql_bin_dir}/mysql -c -uroot -P${mysql_port}  -S  ${mysql_tmp_dir}/mysql.sock -p${tmp_password}  "alter user root@'localhost' identified by 'root';"
		${mysql_bin_dir}/mysql -c -uroot -P${mysql_port}  -S  ${mysql_tmp_dir}/mysql.sock -proot  "create user admin@'%' identified by 'admin';grant all on *.* to admin@'%' with grant option;"
	else
		echo "${mysql_tmp_dir}/mysql.sock  not exists "
		ls -l ${mysql_tmp_dir}
		exit 4
	fi
}

function main(){
	yum_install_packages $packages
	user_add
	dir_add
	dep_install
	mysql_download
	mysql_install
	my_cnf_update
	mysql_server_update
	mysql_start
	mysql_init

}
main



