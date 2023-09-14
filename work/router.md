











# 参数管理

```sql

将router参数session-init-charset=''置空，每次获取连接都会使用客户端指定的字符集。使用管理账户执行如下命令将置空该参数并确认。
dbscale flush connection pool; 
dbscale set global session_init_charset='';
dbscale show options like 'session-init-charset';

客户端连接数据库时指定选项default-character-set='utf8mb4'，使其与后端数据库实例的字符集保持一致，从而避免字符集不一致导致的问题。

mysql --default-character-set='utf8mb4';




```

