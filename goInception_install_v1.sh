#!/bin/bash
linux_user='work'
goInception_host="0.0.0.0"
goInception_port=4000
backup_host="127.0.0.1"
backup_port=3306
backup_user="root"
backup_password="root"
goInception_basedir="/home/${linux_user}/goInception"
goInception_bindir="${goInception_basedir}/bin"
goInception_confir="${goInception_basedir}/conf"
goInception_logdir="${goInception_basedir}/log"

function add_dir() {
        mkdir -p ${goInception_basedir}
        mkdir ${goInception_basedir}/{bin,conf,log}

}

function download_goInception() {
        git clone https://github.com/hanchuanchuan/goInception.git

}

function install_goInception() {
        cd goInception
        go build -o goInception tidb-server/main.go
        cp goInception ${goInception_bindir}

}

function config_update() {
        cp config/config.toml.default ${goInception_confdir}/config.toml
        sed -n "/^backup_host/c backup_host = \"${backup_host}\"" ${goInception_confdir}/config.toml
        sed -n "/^backup_port/c backup_port = \"${backup_port}\"" ${goInception_confdir}/config.toml
        sed -n "/^backup_ user/c backup_user = \"${backup_user}\"" ${goInception_confdir}/config.toml
        sed -n "/^backup_password/c backup_password = \"${backup_password}\"" ${goInception_confdir}/config.toml

}

function start() {
        chown -R work:work $goInception_basedir
        su - work -c "${goInception_bindir}/goInception --config=${goInception_confdir}/config.toml &"

}

function main() {
        cd soft
        add_dir
        download_goInception
        install_goInception
        config_update
        start

}
main
