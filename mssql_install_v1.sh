#!/bin/bash
mssql_sa_user='SA'
mssql_sa_password='mssql_server'
mssql_install_user='root'
mssql_install_password='mssql_server'
mssql_pid='evaluation'
sql_enable_agent='y'

function repo_download() {
        curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2022.repo
        curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo

}

function mssql_install() {
        yum install -y mssql-server
        yum remove unixODBC-utf16 unixODBC-utf16-devel
        yum install -y mssql-tools unixODBC-devel
        yum install -y mssql-server-fts

}

function sa_password() {
        /opt/mssql/bin/mssql-conf setup

}

function mssql_start() {
        systemctl status mssql-server
        sleep 60
        /opt/mssql-tools/bin/sqlcmd -S localhost -U $mssql_sa_user -P ${mssql_sa_password} -Q "SELECT @@VERSION" 2>/dev/null

}

function mssql_user_new() {
        /opt/mssql-tools/bin/sqlcmd -S localhost -U $mssql_sa_user -P ${mssql_sa_password} -Q "CREATE LOGIN [$mssql_install_user] WITH PASSWORD=N'$mssql_install_password', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON; ALTER SERVER ROLE [sysadmin] ADD MEMBER [$mssql_install_user]" 2>/dev/null

}
