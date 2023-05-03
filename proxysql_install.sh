#!/bin/bash
init_time=$(date '+%Y%m%d%H%M%S')

#安装依赖
yum -y install perl-DBD-MySQL


mysql -uadmin -padmin -h127.0.0.1 -P6032  -e "show databases;"
#配置proxysql的应用连接账号
insert into mysql_users(username,password,default_hostgroup) values ('test_wr','123456',1); 
save mysql users to memory;
#配置用于ProxySQL监控账号主要用来检测数据库端是否MYSQL是否正常
grant select ,replication client on *.* to 'monitor'@'10.%' identified by '123456';
update global_variables set variable_value='monitor' where variable_name='mysql-monitor_username';
update global_variables set variable_value='123456' where variable_name='mysql-monitor_password';
#开启ProxySQL monitor模块检查，否则ProxySQL不能检测mysql服务端是否用于正常分发连接
update global_variables set variable_value='true' where  variable_name='mysql-monitor_enabled';
#配置mysql服务器后端连接信息
insert into mysql_servers (hostgroup_id, hostname, port,comment) values(1,'10.10.10.11',3306,'Master节点，主要用于写');
insert into mysql_servers (hostgroup_id, hostname, port,comment) values(2,'10.10.10.11',3306,'主要用于读');
insert into mysql_servers (hostgroup_id, hostname, port,comment) values(2,'10.10.10.22',3306,'主要用于读');
#定义APP应用连接路由规则
insert into mysql_query_rules(rule_id,active,match_digest,destination_hostgroup,apply) values (1,1,'^select.*for update$',1,1);
insert into mysql_query_rules(rule_id,active,match_digest,destination_hostgroup,apply) values (2,1,'^select',2,1);
insert into mysql_query_rules(rule_id,active,match_digest,destination_hostgroup,apply) values (3,1,'^/*master*/ select',1,1);

#所有的参数修改变量必须要加到运行层面，同时要保存到disk中，否则proxysql重启后配置信息会丢失
#针对mysql_users表
load mysql users to run; 
save mysql users to disk;
#针对mysql_servers表
load mysql servers to run; 
save mysql servers to disk; 
#针对mysql_query_rules表
load mysql query rules to run; 
save mysql query rules to disk;
#应用通过提供的VIP地址+端口访问连接数据库（6033）
#应用app通过proxysql的mysql_users表验证用户名和密码，然后通过mysql_query_rules表的匹配规则进行流量分发到mysql server，若无法匹配则走默认组1的mysql server
load mysql users to runtime;
save admin variables to disk;








