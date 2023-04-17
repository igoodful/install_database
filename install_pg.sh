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

