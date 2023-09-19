











# 参数管理

```sql

将router参数session-init-charset=''置空，每次获取连接都会使用客户端指定的字符集。使用管理账户执行如下命令将置空该参数并确认。
dbscale flush connection pool; 
dbscale set global session_init_charset='';
dbscale show options like 'session-init-charset';

客户端连接数据库时指定选项default-character-set='utf8mb4'，使其与后端数据库实例的字符集保持一致，从而避免字符集不一致导致的问题。

mysql --default-character-set='utf8mb4';



dbscale dynamic ADD DATASERVER server_name=slave_dbscale_server,server_host=\"%s\",server_port=%s,server_user=\"%s\",server_password=\"%s\",dbscale_server"


dbscale dynamic add dataserver server_name="slave_dbscale_server",server_host="172.17.138.180",server_port=3307,server_user=admin,server_password='123456';


dbscale dynamic add server datasource slave_dbscale_source slave_dbscale_server-1-1000-400-800 group_id =20;




dbscale dynamic remove datasource "source_name";


 dbscale set global 'slave-dbscale-mode'=0;
 dbscale set global "enable-read-only" = 0;
```

the cluster is follower cluster, do not create.











```bash
2023-09-14 20:31:20.262982 ERROR: not find dbscale process start by this daemon, restart dbscale
Starting DBScale...
./dbscale-service.sh:行155: /proc/sys/net/ipv4/tcp_max_syn_backlog: 权限不够
./dbscale-service.sh:行156: /proc/sys/net/core/somaxconn: 权限不够
done.
2023-09-14 22:50:30.196766 ERROR: not find dbscale process start by this daemon, restart dbscale
Starting DBScale...
./dbscale-service.sh:行155: /proc/sys/net/ipv4/tcp_max_syn_backlog: 权限不够
./dbscale-service.sh:行156: /proc/sys/net/core/somaxconn: 权限不够
done.
2023-09-15 06:34:57.259612 ERROR: not find dbscale process start by this daemon, restart dbscale
Starting DBScale...
./dbscale-service.sh:行155: /proc/sys/net/ipv4/tcp_max_syn_backlog: 权限不够
./dbscale-service.sh:行156: /proc/sys/net/core/somaxconn: 权限不够
done.
2023-09-15 14:09:41.924141 daemon process start
2023-09-15 14:09:43.957031 ERROR: not find dbscale process start by this daemon, restart dbscale
Starting DBScale...
./dbscale-service.sh:行155: /proc/sys/net/ipv4/tcp_max_syn_backlog: 权限不够
./dbscale-service.sh:行156: /proc/sys/net/core/somaxconn: 权限不够
done.
2023-09-15 14:10:11.000981 daemon check disk io
2023-09-15 14:10:20.106104 daemon check disk io
2023-09-15 14:21:54.554757 daemon check disk io
2023-09-15 14:52:13.624301 daemon check disk io
2023-09-15 15:08:47.882680 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:08:53.771444 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:33.500800 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:36.943924 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:40.253439 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:43.486641 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:46.588861 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:51.276100 get error: Connection time-out, when connect zk in clean_master_dbscale_zk_nodes
2023-09-15 15:09:58.866090 WARNING: find dbscale abnormal, restart it
2023-09-15 15:09:59.124250 ERROR: check disk io abnormal
2023-09-15 15:10:06.585618 ERROR: not find dbscale process start by this daemon, restart dbscale
2023-09-15 15:10:23.936961 get error when clean_zk_node
2023-09-15 15:10:24.030271 ERROR: clean zk failed ,plz check zk
2023-09-15 15:10:30.206487 ERROR: not find dbscale process start by this daemon, restart dbscale
Starting DBScale...
./dbscale-service.sh:行155: /proc/sys/net/ipv4/tcp_max_syn_backlog: 权限不够
./dbscale-service.sh:行156: /proc/sys/net/core/somaxconn: 权限不够
done.
2023-09-15 15:11:40.708705 daemon check disk io

```







```
b9da174e-5208-11ee-8c26-00163e2d01d5:1-48,
ba09b02c-5208-11ee-b5af-00163ed307b5:1-114489,
ba245d88-5208-11ee-aae7-00163ee05610:1-4,
f9958bc0-5604-11ee-a5a1-00163ea7a91c:1-4,
f9f2f2be-5604-11ee-b389-00163e3cdeea:1-18


b9da174e-5208-11ee-8c26-00163e2d01d5:1-49,
ba09b02c-5208-11ee-b5af-00163ed307b5:1-114496,
ba245d88-5208-11ee-aae7-00163ee05610:1-4




Executed_Gtid_Set: b9da174e-5208-11ee-8c26-00163e2d01d5:1-49,
ba09b02c-5208-11ee-b5af-00163ed307b5:1-114499,
ba245d88-5208-11ee-aae7-00163ee05610:1-4,
f9958bc0-5604-11ee-a5a1-00163ea7a91c:1-4,
f9f2f2be-5604-11ee-b389-00163e3cdeea:1-18


Executed_Gtid_Set: b9da174e-5208-11ee-8c26-00163e2d01d5:1-49,
ba09b02c-5208-11ee-b5af-00163ed307b5:1-114499,
ba245d88-5208-11ee-aae7-00163ee05610:1-4,
f9958bc0-5604-11ee-a5a1-00163ea7a91c:1-4,
f9f2f2be-5604-11ee-b389-00163e3cdeea:1-20


```


$$
\sqrt(x)+\frac{1}{34}+2^2-a_n
$$





# 灾备



## 一、switchover

注意：该过程不是原子操作

```sql
# 1、连接测试：src和dst
select now()

# 2、设置src
 dbscale set global "enable-read-only" = 1;

# 3、获取并diff src和dst  gtid_executed

# 4、设置src
dbscale dynamic remove datasource slave_dbscale_source;
dbscale dynamic remove dataserver slave_dbscale_server;
dbscale set global 'slave-dbscale-mode'=1;

# 5、设置dst
stop slave;
reset slave all;
dbscale set global 'slave-dbscale-mode'=0;
dbscale dynamic add dataserver server_name=slave_dbscale_server,server_host='172.17.138.180',server_port=3307,server_user='admin',server_password='123456',dbscale_server;

dbscale dynamic add server datasource slave_dbscale_source slave_dbscale_server-1-1000-400-800 group_id =10;
dbscale dynamic add slave slave_dbscale_source to normal_0;
dbscale set global 'enable-read-only'=0;

# 
dbscale set global 'slave-dbscale-mode'=1;
dbscale set global "enable-read-only" = 1;

dbscale show dataservers\G;
dbscale show datasource type=replication\G;





```





















