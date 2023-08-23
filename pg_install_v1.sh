#!/bin/bash
port=5432
pg_version='12.3'
pg_basedir="/data/pg_$port"
pg_package_name="postgresql-${pg_version}.tar.gz"

function install_deps() {
        yum install -y zlib-devel readline-devel gcc python-devel perl-ExtUtils-Embed lrzsz

}

function set_ld_library_path() {
        sed -i '/LD_LIBRARY_PATH/d' /etc/profile
        echo "export LD_LIBRARY_PATH=${pg_basedir}/lib:\$LD_LIBRARY_PATH" >>/etc/profile

}

function add_dir() {
        mkdir -p $pg_basedir
        mkdir -p $pg_basedir/{data,log,tmp,archive}

}

function install_pg() {
        tar -xzvf postgresql-12.3.tar.gz
        cd /data/tmp/dba_tools/softs/postgresql-12.3
        ./configure --prefix=/data/app/postgresql --with-python --with-perl
        make
        make check
        make install

}

function set_pg_conf() {
        cat >$pg_basedir/data/postgresql.conf <<EOF
listen_addresses = '*'
max_connections = 1000
shared_buffers = 2048MB
dynamic_shared_memory_type = posix
wal_level = replica
fsync = on
wal_sync_method = fsync
max_wal_size = 1GB
min_wal_size = 80MB
archive_mode = on
archive_command = 'DIR="/data/postgresql/data_5432/archive/";(test -d $DIR || mkdir -p $DIR)&& cp %p $DIR/%f;find $DIR/* -mmin +360 -exec rm -rf {} \\;'
archive_cleanup_command = 'pg_archivecleanup /data/postgresql/data_5432/pg_wal %r'
recovery_target_timeline = 'latest'
max_wal_senders = 4
wal_keep_segments = 300
synchronous_standby_names = 'harbor'
#primary_conninfo = 'application_name=harbor user=repuser password=repl_pwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any'
hot_standby = on
hot_standby_feedback = on
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_file_mode = 0600
log_timezone = 'PRC'
datestyle = 'iso, mdy'
timezone = 'PRC'
lc_messages = 'en_US.utf8'
lc_monetary = 'en_US.utf8'
lc_numeric = 'en_US.utf8'
lc_time = 'en_US.utf8'
default_text_search_config = 'pg_catalog.english'
# 配置postgresql.conf参数文件，注意：此处和主节点不同之处为多了同步参数：primary_conninfo
# primary_conninfo = 'application_name=harbor user=repuser password=replpwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any'
# connection string to sending server #仅在从节点开启，postgresql.auto.conf文件参数优先级高于此处参数优先级
EOF
        # 编辑standby.signal文件（就在数据文件夹内，以此标识从节点，当从节点提升为主节点后会自动删除，12版本该参数在postgresql.conf配置文件中，不过该文件优先级高于postgresql.conf配置文件）
        cat >$pg_basedir/data/standby.signal <<EOF
standby_mode = 'on'
EOF

        cat >$pg_basedir/data/standby.signal <<EOF
primary_conninfo = 'application_name=harbor user=repuser password=replpwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any'
# connection string to sending server #仅在从节点开启，postgresql.auto.conf文件参数优先级高于此处参数优先级
EOF

        # 此处建议保留以上standby.signal、postgresql.auto.conf两个文件，因为该两个参数文件优先级高于postgresql.conf中参数，在检查的时候会先生效两个文件中的参数
        # 删除则不会提示postgresql.conf中参数应用失败（因为优先应用了两个文件中参数，此处失败可以忽略，建议保留，在流复制初始化从库和切换的时候系统会创建两个文件参数模板，
        # 所以如果保留文件需要保证两个文件参数正确）。且可以根据pg_ctl reload命令直接生效参数并查看参数生否应用和是否需要重启生否

}

function set_pg_hba() {
        cat >$pg_basedir/data/pg_hba.conf <<EOF
host all all 127.0.0.1/32 trust
host all all ::1/128 trust

local replication all trust
host replication all 127.0.0.1/32 trust
host replication all ::1/128 trust
host replication repuser 192.168.59.0/24 trust
host all postgres 192.168.59.0/24 md5
host all harbor 192.168.59.0/24 md5

EOF

}

function start_pg() {
        ${pg_basedir}/bin/pg_ctl -D ${pg_basedir}/data -l logfile start
        ${pg_basedir}/bin/pg_ctl status
        netstat -lnt | grep $port
        # 查看主备角色状态
        pg_controldata | grep 'Database cluster state' # 查看主备角色状态
        # 至此，主备已经搭建完成。登录主从节点查看同步状态信息，sync则为“同步”模式。
        # select usename,application_name,client_addr,sync_state,state from pg_stat_replication;

}

function add_user() {
        cat >a.sql <<EOF
	# 修改postgres密码
	alter user postgres with password 'xxxxxxx';
	# 创建业务用户
	create user harbor with password 'xxxxxx';
	# 创建业务数据库
	create database harbor owner harbor;
	# #授予harbor用户对harbor库的所有权限
	grant all privileges on database harbor to harbor;
	select * from INFORMATION_SCHEMA.table_privileges where grantee='harbor';
	# 查询业务用户授予的权限（因为没有表对象所以此时为空）
	select * from INFORMATION_SCHEMA.role_table_grants where grantee='harbor';
	create role repuser login replication encrypted password 'replpwd';
	#查询当前连接的用户名
	select * from current_user;
	#查询所有用户名
	 \du
	#查询所有数据库名和大小
	select pg_database.datname, pg_size_pretty (pg_database_size(pg_database.datname)) AS size from pg_database;
	#查询数据库详细信息
	 \l
	#登录harbor模式下创建表 psql -h 192.168.59.22 -U harbor
	create table tab1(name varchar(20), signup_date date);
	insert into tab1(name,signup_date) values ('duyqtest',now());
	select *from tab1;
	#主节点查看harbor模式下表
	select * from pg_tables where tableowner='harbor';
	#从节点查看用户、业务库、表信息
	 \du
	select * from pg_tables where tableowner='harbor';
EOF

}

# pg_basebackup -D /data/postgresql/data_5432 -Fp -X stream -R -v -P -h 192.168.59.21 -p 5432 -U repuser
