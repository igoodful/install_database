







```sql

set sql_log_bin=OFF;
set gtid_next='41ded455-40b9-11ee-a2f9-00163ee6d0aa:1';
begin;
commit;
set gtid_next=AUTOMATIC;
set sql_log_bin=on;
show global variables like '%gtid%';
```

