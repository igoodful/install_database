











```sql
set global super_read_only=OFF;
install plugin clone soname "mysql_clone.so";
set global super_read_only=ON;
set global clone_valid_donor_list = '172.17.135.194:16315';
set global super_read_only=OFF;
clone instance from admin@172.17.135.194:16315 identified by "123456";
set global super_read_only=ON;






















```

