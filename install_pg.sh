#!/bin/bash

packages="gcc make zlib-devel readline-devel perl-ExtUtils-Embed"

function yum_install_packages() {
    # 将输入的软件包名称存储到数组中
    local packages=("$@")

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
}

# 编译并安装 PostgreSQL
function build_and_install() {
    local version=$1
    local port=$2
    local install_dir="/home/work/pg_${port}"

    # 进入源码目录
    cd "postgresql-$version"

    # 配置并编译
    echo "正在配置..."
    ./configure --prefix="$install_dir" --without-readline --without-zlib --with-perl --with-python
    echo "正在编译..."
    make

    # 安装
    echo "正在安装..."
    make install

    # 创建数据目录
    echo "正在创建数据目录..."
    mkdir -p "$install_dir/data"
    chown work:work "$install_dir/data"
    chmod 700 "$install_dir/data"

    # 创建日志目录
    echo "正在创建日志目录..."
    mkdir -p "$install_dir/log"
    chown work:work "$install_dir/log"
    chmod 700 "$install_dir/log"

    # 创建临时目录
    echo "正在创建临时目录..."
    mkdir -p "$install_dir/tmp"
    chown work:work "$install_dir/tmp"
    chmod 700 "$install_dir/tmp"
}

function init(){
$install_dir/bin/initdb -D $install_dir/data

}
function conf_update(){
# 新建配置文件
cat >$install_dir/data/postgresql.conf<<EOF

listen_addresses = '*' 
max_connections = 10240 
shared_buffers = 2048MB
dynamic_shared_memory_type = posix
wal_level = replica
fsync = on
wal_sync_method = fsync
max_wal_size = 1GB
min_wal_size = 80MB
archive_mode = on
archive_command = 'DIR="/data/postgresql/data_5432/archive/";(test -d $DIR || mkdir -p $DIR)&& cp %p $DIR/%f;find $DIR/* -mmin +360 -exec rm -rf {} \\;' # command to use to archive a logfile segment
archive_cleanup_command = 'pg_archivecleanup /data/postgresql/data_5432/pg_wal %r' 
recovery_target_timeline = 'latest' 
max_wal_senders = 4 
wal_keep_segments = 300 
synchronous_standby_names = 'myapp' 
##仅在从节点开启，postgresql.auto.conf文件参数优先级高于此处参数优先级
#primary_conninfo = 'application_name=myapp user=repuser password=repl_pwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any' 
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
EOF
echo "==================="
cat > postgresql.auto.conf<<EOF
primary_conninfo = 'application_name=myapp user=repuser password=replpwd host=192.168.59.21 port=5432 sslmode=disable sslcompression=0 gssencmode=disable krbsrvname=postgres target_session_attrs=any' 

EOF
# pg_controldata | grep 'Database cluster state' # 查看主备角色状态
}



# 主程序
function main() {
    local version=$1
    local port=$2
    yum_install_packages $packages
    download_and_extract "$version"
    build_and_install "$version" "$port"
}

# 示例用法
main "13.4" "5432"

