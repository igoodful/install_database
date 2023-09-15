











# 参数管理

```sql

将router参数session-init-charset=''置空，每次获取连接都会使用客户端指定的字符集。使用管理账户执行如下命令将置空该参数并确认。
dbscale flush connection pool; 
dbscale set global session_init_charset='';
dbscale show options like 'session-init-charset';

客户端连接数据库时指定选项default-character-set='utf8mb4'，使其与后端数据库实例的字符集保持一致，从而避免字符集不一致导致的问题。

mysql --default-character-set='utf8mb4';




```











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





































