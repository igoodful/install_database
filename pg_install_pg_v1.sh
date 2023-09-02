#!/bin/bash
pg_version='15.2'
linux_user="work"
port=5432
install_dir="/home/${linux_user}/pg_${port}"
packages="gcc make zlib zlib-devel readline readline-devel openssl openssl-devel openldap openldap-devel pam pam-devel lz4 lz4-devel tcl tcl-devel libxslt libxslt-devel libxml2 libxml2-devel perl-ExtUtils-Embed python-devel python3-devel systemtap-sdt-devel.x86_64"

function yum_install_packages() {
        # 将输入的软件包名称存储到数组中
        local packages=("$@")

        installed=() # 存储已安装的软件包
        not_found=() # 存储不存在的软件包
        failed=()    # 存储安装失败的软件包

        for pkg in "${packages[@]}"; do
                if yum list installed "$pkg" >/dev/null 2>&1; then
                        installed+=("$pkg")
                        echo "$pkg already installed"
                else
                        if yum list available "$pkg" >/dev/null 2>&1; then
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
        echo -e "\033[49;31;1m ---------------------------------->\033[0m"
        echo "Installed packages: ${installed[*]}"
        echo "Not found packages: ${not_found[*]}"
        echo "Failed packages: ${failed[*]}"
        echo -e "\033[49;31;1m ---------------------------------->\033[0m"

        if [ ${#installed[@]} -eq ${#packages[@]} ]; then
                return 0
        else
                #return 1
                echo '存在依赖包未成功安装上 '
                exit 1
        fi
        echo "======="
}

# 检查端口号是否被占用
# 检查用户是否存在
# 检查当前用户是否为root用户
# 检查安装路径是否有数据
function check() {
        lsof -i:$port
        if [ "$?" == "0" ]; then
                echo "$port is used"
                exit 1
        else
                echo "port pass"

        fi

        grep "^${linux_user}:" /etc/passwd
        if [ "$?" == "0" ]; then
                echo "user pass"
        else
                echo "add user $linux_user"
                useradd $linux_user
                echo "$linux_user" | passwd --stdin $linux_user
        fi

        current_user=$(whoami)
        if [ "$current_user" == "root" ]; then
                echo "current user is root ,so pass"
        else
                echo "current user is not root"
                exit 1
        fi
        if [ -x $install_dir ]; then
                if [ -d $install_dir/data ]; then
                        echo "$install_dir/data exists"
                        exit 1
                fi
        else
                mkdir -p $install_dir
        fi
        echo "======="

}

# 下载并解压源码包
function download_and_extract() {
        local version=$1
        local filename="postgresql-$version.tar.gz"
        local url="https://ftp.postgresql.org/pub/source/v$version/$filename"

        # 如果源码包已经存在，则不进行下载
        if [[ -f "$filename" ]]; then
                echo "源码包 $filename 已经存在，跳过下载。"
        else
                echo "正在下载源码包 $filename..."
                wget "$url"
        fi

        # 解压源码包
        tar -xf "$filename"
        echo "======="
}

# 编译并安装 PostgreSQL
function build_and_install() {
        local version=$1
        # 进入源码目录
        cd "postgresql-$version" || echo "postgresql-$version is not exists" && exit 1

        # 配置并编译
        echo "正在配置..."
        ./configure --prefix="$install_dir" --with-pgport=$port --with-perl --with-python3 --with-tcl --with-openssl --with-pam --with-ldap --with-libxml --with-libxslt --with-lz4 --with-gssapi
        # 编译
        if [ "$?" == "0" ]; then
                echo "正在编译..."
                make
                echo "正在检查..."
                make check
        else
                echo -e "\033[49;31;1m configure error\033[0m"
                exit 1
        fi
        if [ "$?" == "0" ]; then
                # 安装
                echo "正在安装..."
                make install
        else
                echo -e "\033[49;31;1m make error\033[0m"
                exit 1
        fi
        # 创建数据目录
        echo "正在创建数据目录..."
        mkdir -p "$install_dir/data"
        chown $linux_user:$linux_user "$install_dir/data"
        chmod 755 "$install_dir/data"

        # 创建归档目录
        echo "正在创建归档目录..."
        mkdir -p "$install_dir/archive"
        chown $linux_user:$linux_user "$install_dir/archive"
        chmod 755 "$install_dir/archive"

        # 创建日志目录
        echo "正在创建日志目录..."
        mkdir -p "$install_dir/log"
        chown $linux_user:$linux_user "$install_dir/log"
        chmod 755 "$install_dir/log"

        # 创建临时目录
        echo "正在创建临时目录..."
        mkdir -p "$install_dir/tmp"
        chown $linux_user:$linux_user "$install_dir/tmp"
        chmod 755 "$install_dir/tmp"
        echo "======="
}

function pg_initdb() {
        if [ -f $install_dir/bin/initdb ]; then
                su - $linux_user -c "$install_dir/bin/initdb --pgdata=$install_dir/data --username=$linux_user --encoding=UTF8 --lc-collate=C --lc-ctype=en_US.utf8"
        else
                echo "$install_dir/bin/initdb is not exists"
                exit 1
        fi
        echo "======="
}
function set_postgresql_conf() {
        mem_total=$(free -g | grep Mem | awk '{print $2}')
        shared_buffers=$(expr $mem_total / 4)
        if [ "$shared_buffers" = "0" ]; then
                shared_buffers=1
        fi
        effective_cache_size=$(expr $mem_total / 2)
        if [ "$effective_cache_size" = "0" ]; then
                effective_cache_size=1
        fi
        max_wal_size=$(expr $mem_total / 2)
        if [ -e $install_dir/data/base ]; then
                # 新建配置文件
                cat >$install_dir/data/postgresql.conf <<EOF
listen_addresses = '*'
port = $port
max_connections = 10240
shared_buffers = ${shared_buffers}GB
effective_cache_size = ${effective_cache_size}GB
work_mem = 64MB
maintenance_work_mem = 512MB
dynamic_shared_memory_type = posix
wal_level = replica
fsync = on
wal_sync_method = fsync
max_wal_size = ${max_wal_size}GB
min_wal_size = 1GB

# 归档配置，默认只保存15天数据
archive_mode = on
archive_command = 'archive_dir="$install_dir/archive";(test -d \${archive_dir} || mkdir -p \${archive_dir}) && cp %p \${archive_dir}/%f;find \${archive_dir}/* -mtime +15 -exec rm -rf {} \;'

# 恢复时使用
# restore_command = 'cp $install_dir/archive/%f %p'
# recovery_target_timeline = 'latest'
# archive_cleanup_command = 'pg_archivecleanup /data/postgresql/data_5432/pg_wal %r'

max_wal_senders = 64
wal_sender_timeout = 60s
wal_receiver_timeout = 60s
wal_receiver_status_interval = 10s
# wal_keep_segments = 300
synchronous_commit = 'local'
synchronous_standby_names = '*'

# 仅在从节点开启，postgresql.auto.conf文件参数优先级高于此处参数优先级
# primary_conninfo = 'application_name=myapp user=repuser password=repl_pwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any'
hot_standby = on
hot_standby_feedback = on
checkpoint_timeout = 5min

# 日志配置
logging_collector = on
log_destination = 'csvlog'
log_directory = '$install_dir/log'
log_filename = 'pg-%Y-%m-%d_%H%M%S.log'
log_file_mode = 0640
log_rotation_age = 1d
log_rotation_size = 1GB
log_truncate_on_rotation = on
log_checkpoints = on
log_connections = off
log_disconnections = off
log_error_verbosity = verbose
log_lock_waits = on
log_statement = 'ddl'
log_min_messages = WARNING
log_min_error_statement = ERROR
log_duration = on
log_min_duration_statement = 5000
log_timezone = 'Asia/Shanghai'
log_replication_commands = on
log_hostname = off
deadlock_timeout = 1

log_autovacuum_min_duration = 0
autovacuum_vacuum_scale_factor=0.001
autovacuum = on
autovacuum_max_workers = 4

timezone = 'Asia/Shanghai'
datestyle = 'iso, mdy'
lc_messages = 'en_US.utf8'
lc_monetary = 'en_US.utf8'
lc_numeric = 'en_US.utf8'
lc_time = 'en_US.utf8'
default_text_search_config = 'pg_catalog.english'
EOF
                echo "==================="
                cat >postgresql.auto.conf <<EOF
#primary_conninfo = 'application_name=myapp user=repuser password=replpwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any'

EOF
        else
                echo "$install_dir/data/base is not exists"
                exit 1
        fi
        chown -R $linux_user:$linux_user $install_dir
        echo "======="
        # pg_controldata | grep 'Database cluster state' # 查看主备角色状态
}

# 设置 pg_hba.conf
function set_pg_hba_conf() {
        echo "设置 $install_dir/data/pg_hba.conf"
        cat >$install_dir/data/pg_hba.conf <<EOF
# 格式：TYPE  DATABASE        USER            ADDRESS                 METHOD
# 注意: ALL不匹配replication
host replication repuser 0.0.0.0/0 md5
host all         all     0.0.0.0/0 md5

EOF
}

function start() {
        if [ -f $install_dir/bin/pg_ctl ]; then
                su - $linux_user -c "$install_dir/bin/pg_ctl -D $install_dir/data  start"
                sleep 10
                lsof -i:$port
                if [ "$?" == "0" ]; then
                        echo "pg_ctl success start"
                else
                        echo "pg_ctl not success start"
                        exit 1
                fi

        else
                echo "$install_dir/bin/pg_ctl is not exists"
                exit 1
        fi
        echo "======="

}

function pg_init() {
        echo "pg_init..."
        su - $linux_user -c "$install_dir/bin/psql -d postgres -c 'select version();' "
        echo "创建复制用户：repuser"
        su - $linux_user -c "$install_dir/bin/psql -d postgres -c 'create user repuser  replication  login encrypted  password 'repuser';' "
        echo "pg_basebackup -D $install_dir/data -Fp -X stream -R -v -P -h 127.0.0.1 -p ${port} -U repuser"
}

# 主程序
function main() {
        check
        yum_install_packages $packages
        download_and_extract "$pg_version"
        build_and_install "$pg_version"
        pg_initdb
        set_postgresql_conf
        set_pg_hba_conf
        start
        pg_init
        echo "======="
}

# 示例用法
main
