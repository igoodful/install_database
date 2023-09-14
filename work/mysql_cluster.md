# uf 







```sql









change master to master_host='172.17.135.193',master_port=16315,master_user='dbscale_internal',master_password='123456',master_auto_position=1;


mysql> show global variables like '%server%';
+---------------------------------+--------------------------------------+
| Variable_name                   | Value                                |
+---------------------------------+--------------------------------------+
| character_set_server            | utf8mb4                              |
| collation_server                | utf8mb4_0900_ai_ci                   |
| innodb_dedicated_server         | OFF                                  |
| innodb_ft_server_stopword_table |                                      |
| server_id                       | 4294967295                           |
| server_id_bits                  | 32                                   |
| server_uuid                     | bc83b51d-40e5-11ee-954a-00163ee6d0aa |
+---------------------------------+--------------------------------------+
7 rows in set (0.01 sec)

mysql> 




mysql> show global variables like '%server%';
+---------------------------------+--------------------------------------+
| Variable_name                   | Value                                |
+---------------------------------+--------------------------------------+
| character_set_server            | utf8mb4                              |
| collation_server                | utf8mb4_0900_ai_ci                   |
| innodb_dedicated_server         | OFF                                  |
| innodb_ft_server_stopword_table |                                      |
| server_id                       | 4294967295                           |
| server_id_bits                  | 32                                   |
| server_uuid                     | c56f9aa9-40e5-11ee-9c4a-00163efbfe20 |
+---------------------------------+--------------------------------------+







mysql> show global variables like '%server%';
+---------------------------------+--------------------------------------+
| Variable_name                   | Value                                |
+---------------------------------+--------------------------------------+
| character_set_server            | utf8mb4                              |
| collation_server                | utf8mb4_0900_ai_ci                   |
| innodb_dedicated_server         | OFF                                  |
| innodb_ft_server_stopword_table |                                      |
| server_id                       | 9867315                              |
| server_id_bits                  | 32                                   |
| server_uuid                     | ff80d169-40e6-11ee-b4a3-00163e8c6cf2 |
+---------------------------------+--------------------------------------+



set global gtid_purged='41ded455-40b9-11ee-a2f9-00163ee6d0aa:1,85414318-40ba-11ee-b1e5-00163e8c6cf2:1,bc83b51d-40e5-11ee-954a-00163ee6d0aa:1,e08050aa-4095-11ee-8361-00163e48fc5c:1-17313';





# 
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:1';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:2';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:3';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:4';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:5';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:6';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:7';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:8';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:9';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:10';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:11';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:12';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:13';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:14';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:15';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:16';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:17';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:18';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:19';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:20';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:21';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:22';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:23';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:24';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:25';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:26';
begin;
commit;
set session gtid_next = automatic;
set session gtid_next= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:27';
begin;
commit;
set session gtid_next = automatic;


1e142217-40eb-11ee-b4a2-00163ee6d0aa:1
1e142217-40eb-11ee-b4a2-00163ee6d0aa:2
1e142217-40eb-11ee-b4a2-00163ee6d0aa:3
1e142217-40eb-11ee-b4a2-00163ee6d0aa:4
1e142217-40eb-11ee-b4a2-00163ee6d0aa:5

1e142217-40eb-11ee-b4a2-00163ee6d0aa:6
1e142217-40eb-11ee-b4a2-00163ee6d0aa:7
1e142217-40eb-11ee-b4a2-00163ee6d0aa:8
1e142217-40eb-11ee-b4a2-00163ee6d0aa:9
1e142217-40eb-11ee-b4a2-00163ee6d0aa:10

1e142217-40eb-11ee-b4a2-00163ee6d0aa:11
1e142217-40eb-11ee-b4a2-00163ee6d0aa:12
1e142217-40eb-11ee-b4a2-00163ee6d0aa:13
1e142217-40eb-11ee-b4a2-00163ee6d0aa:14
1e142217-40eb-11ee-b4a2-00163ee6d0aa:15

1e142217-40eb-11ee-b4a2-00163ee6d0aa:16
1e142217-40eb-11ee-b4a2-00163ee6d0aa:17
1e142217-40eb-11ee-b4a2-00163ee6d0aa:18
1e142217-40eb-11ee-b4a2-00163ee6d0aa:19
1e142217-40eb-11ee-b4a2-00163ee6d0aa:20

1e142217-40eb-11ee-b4a2-00163ee6d0aa:21
1e142217-40eb-11ee-b4a2-00163ee6d0aa:22
1e142217-40eb-11ee-b4a2-00163ee6d0aa:23
1e142217-40eb-11ee-b4a2-00163ee6d0aa:24
1e142217-40eb-11ee-b4a2-00163ee6d0aa:25

1e142217-40eb-11ee-b4a2-00163ee6d0aa:26
1e142217-40eb-11ee-b4a2-00163ee6d0aa:27


```

