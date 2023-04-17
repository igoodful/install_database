#!/bin/bash

# 安装 MongoDB 副本集成员
function install_mongodb() {
    # 检查是否已经安装
    if command -v mongod >/dev/null; then
        echo "MongoDB 已经安装，跳过安装。"
        return
    fi

    # 设置默认变量
    local version="5.0.5"
    local install_dir="/opt/mongodb"

    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            -v | --version)
                version="$2"
                shift 2
                ;;
            -d | --install-dir)
                install_dir="$2"
                shift 2
                ;;
            *)
                echo "错误：未知的参数 $1"
                exit 1
                ;;
        esac
    done

    # 下载二进制文件
# wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-rhel70-6.0.5.tgz
    
local download_url="https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$version.tgz"
    local archive_path="/tmp/mongodb-$version.tgz"
    echo "正在下载 $download_url"
    if ! curl --progress-bar --location --output "$archive_path" "$download_url"; then
        echo "下载 MongoDB 失败，请检查网络或版本是否正确。"
        exit 1
    fi

    # 解压文件
    local extract_path="/tmp/mongodb-$version"
    echo "正在解压 $archive_path 到 $extract_path"
    if ! tar -xzf "$archive_path" -C "/tmp"; then
        echo "解压 MongoDB 文件失败。"
        exit 1
    fi

    # 安装到指定目录
    echo "正在安装 MongoDB 到 $install_dir"
    local extracted_dir="/tmp/mongodb-linux-x86_64-$version"
    if ! mv "$extracted_dir" "$install_dir"; then
        echo "移动 MongoDB 到 $install_dir 失败。"
        exit 1
    fi

    # 创建必要的目录
    echo "正在创建 MongoDB 数据目录、日志目录和临时目录"
    local data_dir="$install_dir/data"
    local log_dir="$install_dir/log"
    local tmp_dir="$install_dir/tmp"
    local conf_dir="$install_dir/conf"
    mkdir -p "$data_dir" "$log_dir" "$tmp_dir" "$conf_dir"
    chmod 777 "$log_dir" "$tmp_dir"
    chown -R mongodb:mongodb "$install_dir"

    # 启动 MongoDB
    echo "启动 MongoDB"
    mongod --fork --logpath "$log_dir/mongod.log" --dbpath "$data_dir" --bind_ip_all --port 27017 --replSet "rs0"
}


# 主程序
function main() {
install_mongodb -v "5.0.5" -d /home/work/mongodb_27017

}           
main
