```shell
[mysql@gip180 dbdata]$ which mysqlbinlog
/usr/bin/mysqlbinlog
[mysql@gip180 dbdata]$ ldd /usr/bin/mysqlbinlog
	linux-vdso.so.1 (0x00007fff76fd0000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007fac3d1a6000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007fac3d18d000)
	librt.so.1 => /lib64/librt.so.1 (0x00007fac3d182000)
	libssl.so.10 => not found
	libcrypto.so.10 => not found
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fac3d17d000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fac3cfc8000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fac3ce45000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fac3ce2c000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fac3cc74000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fac3d1d9000)
[mysql@gip180 dbdata]$ ldd /data/app/mysql-8.0.26/bin/mysqlbinlog
	linux-vdso.so.1 (0x00007ffdf252f000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f753b481000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f753b47c000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x00007f753b463000)
	librt.so.1 => /lib64/librt.so.1 (0x00007f753b458000)
	libcrypto.so.1.1 => /data/app/mysql-8.0.26/bin/../lib/private/libcrypto.so.1.1 (0x00007f753af89000)
	libssl.so.1.1 => /data/app/mysql-8.0.26/bin/../lib/private/libssl.so.1.1 (0x00007f753acf7000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f753ab42000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f753a9bf000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f753a9a6000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f753a7ee000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f753b4b4000)
	
	
	
	
	
	
	
	
	# The proper term is pseudo_replica_mode, but we use this compatibility alias
# to make the statement usable on server versions 8.0.24 and older.
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#230822 20:55:20 server id 44049365  end_log_pos 125    Start: binlog v 4, server v 8.0.26 created 230822 20:55:20 at startup
ROLLBACK/*!*/;
# at 125
#230822 20:55:20 server id 44049365  end_log_pos 152    Previous-GTIDs
# [empty]
# at 152
#230822 20:55:50 server id 44049365  end_log_pos 227    GTID    last_committed=0        sequence_number=1       rbr_only=no     original_committed_timestamp=1692708950692494   immediate_commit_timestamp=1692708950692494     transaction_length=1220
# original_commit_timestamp=1692708950692494 (2023-08-22 20:55:50.692494 CST)
# immediate_commit_timestamp=1692708950692494 (2023-08-22 20:55:50.692494 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950692494*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:1'/*!*/;
# at 227
#230822 20:55:50 server id 44049365  end_log_pos 1372   Query   thread_id=14    exec_time=0     error_code=0    Xid = 192
SET TIMESTAMP=1692708950/*!*/;
SET @@session.pseudo_thread_id=14/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1168113696/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8mb3 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=255/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
/*!80011 SET @@session.default_collation_for_utf8mb4=255*//*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS `dbscale`.`COLUMNS` (  `TABLE_CATALOG` varchar(64) DEFAULT '',  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',  `ORDINAL_POSITION` int unsigned DEFAULT '0',  `COLUMN_DEFAULT` text,  `IS_NULLABLE` varchar(3) DEFAULT '',  `DATA_TYPE` longtext,  `CHARACTER_MAXIMUM_LENGTH` bigint unsigned DEFAULT NULL,  `CHARACTER_OCTET_LENGTH` bigint unsigned DEFAULT NULL,  `NUMERIC_PRECISION` bigint unsigned DEFAULT NULL,  `NUMERIC_SCALE` bigint unsigned DEFAULT NULL,  `DATETIME_PRECISION` int unsigned DEFAULT NULL,  `CHARACTER_SET_NAME` varchar(64) DEFAULT NULL,  `COLLATION_NAME` varchar(64) DEFAULT NULL,  `COLUMN_TYPE` mediumtext,  `COLUMN_KEY` enum('','PRI','UNI','MUL') DEFAULT '',  `EXTRA` varchar(256) DEFAULT '',  `PRIVILEGES` varchar(154) DEFAULT '',  `COLUMN_COMMENT` text,  `GENERATION_EXPRESSION` longtext,  `SRS_ID` int unsigned DEFAULT NULL,  PRIMARY KEY (`TABLE_SCHEMA`,`TABLE_NAME`,`COLUMN_NAME`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!*/;
# at 1372
#230822 20:55:50 server id 44049365  end_log_pos 1447   GTID    last_committed=1        sequence_number=2       rbr_only=no     original_committed_timestamp=1692708950710191   immediate_commit_timestamp=1692708950710191     transaction_length=1006
# original_commit_timestamp=1692708950710191 (2023-08-22 20:55:50.710191 CST)
# immediate_commit_timestamp=1692708950710191 (2023-08-22 20:55:50.710191 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950710191*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:2'/*!*/;
# at 1447
#230822 20:55:50 server id 44049365  end_log_pos 2378   Query   thread_id=14    exec_time=0     error_code=0    Xid = 193
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS `dbscale`.`KEY_COLUMN_USAGE` (  `CONSTRAINT_CATALOG` varchar(64) DEFAULT '',  `CONSTRAINT_SCHEMA` varchar(64) NOT NULL DEFAULT '',  `CONSTRAINT_NAME` varchar(64) NOT NULL DEFAULT '',  `TABLE_CATALOG` varchar(64) DEFAULT '',  `TABLE_SCHEMA` varchar(64) NOT NULL DEFAULT '',  `TABLE_NAME` varchar(64) NOT NULL DEFAULT '',  `COLUMN_NAME` varchar(64) NOT NULL DEFAULT '',  `ORDINAL_POSITION` int unsigned DEFAULT '0',  `POSITION_IN_UNIQUE_CONSTRAINT` int unsigned DEFAULT NULL,  `REFERENCED_TABLE_SCHEMA` varchar(64) DEFAULT NULL,  `REFERENCED_TABLE_NAME` varchar(64) DEFAULT NULL,  `REFERENCED_COLUMN_NAME` varchar(64) DEFAULT NULL,  PRIMARY KEY (`CONSTRAINT_SCHEMA`,`CONSTRAINT_NAME`,`TABLE_SCHEMA`,`TABLE_NAME`,`COLUMN_NAME`),  KEY `idx_1` (`TABLE_SCHEMA`,`TABLE_NAME`,`COLUMN_NAME`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
/*!*/;
# at 2378
#230822 20:55:50 server id 44049365  end_log_pos 2453   GTID    last_committed=2        sequence_number=3       rbr_only=no     original_committed_timestamp=1692708950823914   immediate_commit_timestamp=1692708950823914     transaction_length=368
# original_commit_timestamp=1692708950823914 (2023-08-22 20:55:50.823914 CST)
# immediate_commit_timestamp=1692708950823914 (2023-08-22 20:55:50.823914 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950823914*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:3'/*!*/;
# at 2453
#230822 20:55:50 server id 44049365  end_log_pos 2746   Query   thread_id=21    exec_time=0     error_code=0    Xid = 196
SET TIMESTAMP=1692708950/*!*/;
/*!\C latin1 *//*!*/;
SET @@session.character_set_client=8,@@session.collation_connection=8,@@session.collation_server=255/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.PARTITION_SCHEME (name varchar(600) primary key, type varchar(20), partitions text, hash_method varchar(20), is_shard int, shard_map text) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 2746
#230822 20:55:50 server id 44049365  end_log_pos 2821   GTID    last_committed=3        sequence_number=4       rbr_only=no     original_committed_timestamp=1692708950838644   immediate_commit_timestamp=1692708950838644     transaction_length=374
# original_commit_timestamp=1692708950838644 (2023-08-22 20:55:50.838644 CST)
# immediate_commit_timestamp=1692708950838644 (2023-08-22 20:55:50.838644 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950838644*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:4'/*!*/;
# at 2821
#230822 20:55:50 server id 44049365  end_log_pos 3120   Query   thread_id=21    exec_time=0     error_code=0    Xid = 197
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.SCHEMA(name varchar(100), source varchar(100), independence int, alias_real_name varchar(100), pushdown_stored_procedure int, primary key(name)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 3120
#230822 20:55:50 server id 44049365  end_log_pos 3195   GTID    last_committed=4        sequence_number=5       rbr_only=no     original_committed_timestamp=1692708950853074   immediate_commit_timestamp=1692708950853074     transaction_length=384
# original_commit_timestamp=1692708950853074 (2023-08-22 20:55:50.853074 CST)
# immediate_commit_timestamp=1692708950853074 (2023-08-22 20:55:50.853074 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950853074*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:5'/*!*/;
# at 3195
#230822 20:55:50 server id 44049365  end_log_pos 3504   Query   thread_id=21    exec_time=0     error_code=0    Xid = 198
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.NORM_TABLE (name varchar(100), schema_name varchar(100), source varchar(100), independence int, name_pattern varchar(100), primary key(name, schema_name)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 3504
#230822 20:55:50 server id 44049365  end_log_pos 3579   GTID    last_committed=5        sequence_number=6       rbr_only=no     original_committed_timestamp=1692708950866198   immediate_commit_timestamp=1692708950866198     transaction_length=464
# original_commit_timestamp=1692708950866198 (2023-08-22 20:55:50.866198 CST)
# immediate_commit_timestamp=1692708950866198 (2023-08-22 20:55:50.866198 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950866198*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:6'/*!*/;
# at 3579
#230822 20:55:50 server id 44049365  end_log_pos 3968   Query   thread_id=21    exec_time=0     error_code=0    Xid = 199
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.PARTITIONED_TABLE (name varchar(100), schema_name varchar(100), part_key varchar(100), scheme varchar(600), part_type int, independence int, virtual_time int, virtual_map text, name_pattern varchar(100),primary key(name, schema_name)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 3968
#230822 20:55:50 server id 44049365  end_log_pos 4043   GTID    last_committed=6        sequence_number=7       rbr_only=no     original_committed_timestamp=1692708950884470   immediate_commit_timestamp=1692708950884470     transaction_length=590
# original_commit_timestamp=1692708950884470 (2023-08-22 20:55:50.884470 CST)
# immediate_commit_timestamp=1692708950884470 (2023-08-22 20:55:50.884470 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950884470*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:7'/*!*/;
# at 4043
#230822 20:55:50 server id 44049365  end_log_pos 4558   Query   thread_id=21    exec_time=0     error_code=0    Xid = 200
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.MIGRATE (name varchar(100), schema_name varchar(100), source_schema_name varchar(100), target_schema_name varchar(100), source varchar(100), target_source varchar(100), table_type int, vid varchar(1000), state int, migrate_direct_clean_data int, migrate_method int, primary key(name, schema_name, source_schema_name, target_sc
hema_name, source, target_source)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 4558
#230822 20:55:50 server id 44049365  end_log_pos 4633   GTID    last_committed=7        sequence_number=8       rbr_only=no     original_committed_timestamp=1692708950897995   immediate_commit_timestamp=1692708950897995     transaction_length=272
# original_commit_timestamp=1692708950897995 (2023-08-22 20:55:50.897995 CST)
# immediate_commit_timestamp=1692708950897995 (2023-08-22 20:55:50.897995 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950897995*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:8'/*!*/;
# at 4633
#230822 20:55:50 server id 44049365  end_log_pos 4830   Query   thread_id=21    exec_time=0     error_code=0    Xid = 201
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.DBSCALE_INC_INFO(table_name varchar(128) primary key, value long) Engine=innodb
/*!*/;
# at 4830
#230822 20:55:50 server id 44049365  end_log_pos 4905   GTID    last_committed=8        sequence_number=9       rbr_only=no     original_committed_timestamp=1692708950912823   immediate_commit_timestamp=1692708950912823     transaction_length=368
# original_commit_timestamp=1692708950912823 (2023-08-22 20:55:50.912823 CST)
# immediate_commit_timestamp=1692708950912823 (2023-08-22 20:55:50.912823 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950912823*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:9'/*!*/;
# at 4905
#230822 20:55:50 server id 44049365  end_log_pos 5198   Query   thread_id=21    exec_time=0     error_code=0    Xid = 202
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.MIGRATE_CLEAN_SHARD(id int auto_increment primary key, table_name varchar(128), schema_name varchar(128),clean_table_name varchar(256), source_name varchar(128)) Engine=innodb
/*!*/;
# at 5198
#230822 20:55:50 server id 44049365  end_log_pos 5273   GTID    last_committed=9        sequence_number=10      rbr_only=no     original_committed_timestamp=1692708950926524   immediate_commit_timestamp=1692708950926524     transaction_length=316
# original_commit_timestamp=1692708950926524 (2023-08-22 20:55:50.926524 CST)
# immediate_commit_timestamp=1692708950926524 (2023-08-22 20:55:50.926524 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950926524*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:10'/*!*/;
# at 5273
#230822 20:55:50 server id 44049365  end_log_pos 5514   Query   thread_id=21    exec_time=0     error_code=0    Xid = 203
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.XID_INFO (xid bigint Unsigned not NULL, cluster_id int, primary key (xid, cluster_id)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 5514
#230822 20:55:50 server id 44049365  end_log_pos 5589   GTID    last_committed=10       sequence_number=11      rbr_only=no     original_committed_timestamp=1692708950941292   immediate_commit_timestamp=1692708950941292     transaction_length=398
# original_commit_timestamp=1692708950941292 (2023-08-22 20:55:50.941292 CST)
# immediate_commit_timestamp=1692708950941292 (2023-08-22 20:55:50.941292 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950941292*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:11'/*!*/;
# at 5589
#230822 20:55:50 server id 44049365  end_log_pos 5912   Query   thread_id=21    exec_time=0     error_code=0    Xid = 204
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.WHITE_USER_INFO (user_name varchar(64) not null, ip varchar(20), comment varchar(512) default '', dbscale_cluster_id int,primary key (user_name, ip , dbscale_cluster_id)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 5912
#230822 20:55:50 server id 44049365  end_log_pos 5987   GTID    last_committed=11       sequence_number=12      rbr_only=no     original_committed_timestamp=1692708950964650   immediate_commit_timestamp=1692708950964650     transaction_length=284
# original_commit_timestamp=1692708950964650 (2023-08-22 20:55:50.964650 CST)
# immediate_commit_timestamp=1692708950964650 (2023-08-22 20:55:50.964650 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950964650*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:12'/*!*/;
# at 5987
#230822 20:55:50 server id 44049365  end_log_pos 6196   Query   thread_id=21    exec_time=0     error_code=0    Xid = 205
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.AUDIT_USER(username varchar(128), primary key(username)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 6196
#230822 20:55:50 server id 44049365  end_log_pos 6271   GTID    last_committed=12       sequence_number=13      rbr_only=no     original_committed_timestamp=1692708950978154   immediate_commit_timestamp=1692708950978154     transaction_length=388
# original_commit_timestamp=1692708950978154 (2023-08-22 20:55:50.978154 CST)
# immediate_commit_timestamp=1692708950978154 (2023-08-22 20:55:50.978154 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950978154*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:13'/*!*/;
# at 6271
#230822 20:55:50 server id 44049365  end_log_pos 6584   Query   thread_id=21    exec_time=0     error_code=0    Xid = 206
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.SCHEMA_ACL_INFO(user_name varchar(64), schema_name varchar(64), type bigint,dbscale_cluster_id int,primary key name(user_name, schema_name, dbscale_cluster_id)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 6584
#230822 20:55:50 server id 44049365  end_log_pos 6659   GTID    last_committed=13       sequence_number=14      rbr_only=no     original_committed_timestamp=1692708950994835   immediate_commit_timestamp=1692708950994835     transaction_length=366
# original_commit_timestamp=1692708950994835 (2023-08-22 20:55:50.994835 CST)
# immediate_commit_timestamp=1692708950994835 (2023-08-22 20:55:50.994835 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708950994835*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:14'/*!*/;
# at 6659
#230822 20:55:50 server id 44049365  end_log_pos 6950   Query   thread_id=21    exec_time=0     error_code=0    Xid = 207
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.TABLE_ACL_INFO(user_name varchar(64), full_table_name varchar(128), type bigint, primary key (user_name, full_table_name), key(user_name)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 6950
#230822 20:55:50 server id 44049365  end_log_pos 7025   GTID    last_committed=14       sequence_number=15      rbr_only=no     original_committed_timestamp=1692708951008684   immediate_commit_timestamp=1692708951008684     transaction_length=351
# original_commit_timestamp=1692708951008684 (2023-08-22 20:55:51.008684 CST)
# immediate_commit_timestamp=1692708951008684 (2023-08-22 20:55:51.008684 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951008684*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:15'/*!*/;
# at 7025
#230822 20:55:50 server id 44049365  end_log_pos 7301   Query   thread_id=21    exec_time=1     error_code=0    Xid = 208
SET TIMESTAMP=1692708950/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.USER_NOT_ALLOW_OPERATION_TIME (user_name varchar(128), from_sec int, to_sec int, primary key (user_name, from_sec, to_sec)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 7301
#230822 20:55:51 server id 44049365  end_log_pos 7376   GTID    last_committed=15       sequence_number=16      rbr_only=no     original_committed_timestamp=1692708951021184   immediate_commit_timestamp=1692708951021184     transaction_length=345
# original_commit_timestamp=1692708951021184 (2023-08-22 20:55:51.021184 CST)
# immediate_commit_timestamp=1692708951021184 (2023-08-22 20:55:51.021184 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951021184*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:16'/*!*/;
# at 7376
#230822 20:55:51 server id 44049365  end_log_pos 7646   Query   thread_id=21    exec_time=0     error_code=0    Xid = 209
SET TIMESTAMP=1692708951/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.VIEWS (SCHEMA_NAME varchar(128), VIEW_NAME varchar(128), VIEW_DEFINITION text, primary key(SCHEMA_NAME, VIEW_NAME)) engine = innodb DEFAULT CHARSET=utf8
/*!*/;
# at 7646
#230822 20:55:51 server id 44049365  end_log_pos 7721   GTID    last_committed=16       sequence_number=17      rbr_only=no     original_committed_timestamp=1692708951034414   immediate_commit_timestamp=1692708951034414     transaction_length=351
# original_commit_timestamp=1692708951034414 (2023-08-22 20:55:51.034414 CST)
# immediate_commit_timestamp=1692708951034414 (2023-08-22 20:55:51.034414 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951034414*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:17'/*!*/;
# at 7721
#230822 20:55:51 server id 44049365  end_log_pos 7997   Query   thread_id=21    exec_time=0     error_code=0    Xid = 210
SET TIMESTAMP=1692708951/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.VIEW_CHARSET (SCHEMA_NAME varchar(128), VIEW_NAME varchar(128), CHARSET varchar(32), primary key(SCHEMA_NAME, VIEW_NAME)) engine = innodb DEFAULT CHARSET=utf8
/*!*/;
# at 7997
#230822 20:55:51 server id 44049365  end_log_pos 8072   GTID    last_committed=17       sequence_number=18      rbr_only=no     original_committed_timestamp=1692708951045708   immediate_commit_timestamp=1692708951045708     transaction_length=291
# original_commit_timestamp=1692708951045708 (2023-08-22 20:55:51.045708 CST)
# immediate_commit_timestamp=1692708951045708 (2023-08-22 20:55:51.045708 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951045708*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:18'/*!*/;
# at 8072
#230822 20:55:51 server id 44049365  end_log_pos 8288   Query   thread_id=21    exec_time=0     error_code=0    Xid = 211
SET TIMESTAMP=1692708951/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.MIRROR_USER (USER_NAME varchar(128), primary key (USER_NAME)) ENGINE=INNODB DEFAULT CHARSET=latin1
/*!*/;
# at 8288
#230822 20:55:51 server id 44049365  end_log_pos 8363   GTID    last_committed=18       sequence_number=19      rbr_only=no     original_committed_timestamp=1692708951058118   immediate_commit_timestamp=1692708951058118     transaction_length=328
# original_commit_timestamp=1692708951058118 (2023-08-22 20:55:51.058118 CST)
# immediate_commit_timestamp=1692708951058118 (2023-08-22 20:55:51.058118 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951058118*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:19'/*!*/;
# at 8363
#230822 20:55:51 server id 44049365  end_log_pos 8616   Query   thread_id=21    exec_time=0     error_code=0    Xid = 212
SET TIMESTAMP=1692708951/*!*/;
/*!80013 SET @@session.sql_require_primary_key=1*//*!*/;
CREATE TABLE IF NOT EXISTS dbscale.USER_LOAD_BALANCE_STRATEGY(user varchar(128), load_balance_strategy varchar(64), primary key (user)) ENGINE=INNODB DEFAULT CHARSET=utf8
/*!*/;
# at 8616
#230822 20:55:51 server id 44049365  end_log_pos 8689   GTID    last_committed=19       sequence_number=20      rbr_only=no     original_committed_timestamp=1692708951098837   immediate_commit_timestamp=1692708951098837     transaction_length=177
# original_commit_timestamp=1692708951098837 (2023-08-22 20:55:51.098837 CST)
# immediate_commit_timestamp=1692708951098837 (2023-08-22 20:55:51.098837 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708951098837*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:20'/*!*/;
# at 8689
#230822 20:55:51 server id 44049365  end_log_pos 8793   Query   thread_id=21    exec_time=0     error_code=0    Xid = 247
SET TIMESTAMP=1692708951/*!*/;
/*!\C utf8mb3 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=255/*!*/;
truncate dbscale.DBSCALE_INC_INFO
/*!*/;
# at 8793
#230822 20:55:54 server id 44049365  end_log_pos 8866   GTID    last_committed=20       sequence_number=21      rbr_only=no     original_committed_timestamp=1692708954720366   immediate_commit_timestamp=1692708954720366     transaction_length=232
# original_commit_timestamp=1692708954720366 (2023-08-22 20:55:54.720366 CST)
# immediate_commit_timestamp=1692708954720366 (2023-08-22 20:55:54.720366 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708954720366*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:21'/*!*/;
# at 8866
#230822 20:55:54 server id 44049365  end_log_pos 9025   Query   thread_id=21    exec_time=0     error_code=0    Xid = 297
use `information_schema`/*!*/;
SET TIMESTAMP=1692708954/*!*/;
SET @@session.foreign_key_checks=0/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%'
/*!*/;
# at 9025
#230822 20:55:54 server id 44049365  end_log_pos 9100   GTID    last_committed=21       sequence_number=22      rbr_only=yes    original_committed_timestamp=1692708954747872   immediate_commit_timestamp=1692708954747872     transaction_length=375
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1692708954747872 (2023-08-22 20:55:54.747872 CST)
# immediate_commit_timestamp=1692708954747872 (2023-08-22 20:55:54.747872 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708954747872*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:22'/*!*/;
# at 9100
#230822 20:55:54 server id 44049365  end_log_pos 9167   Query   thread_id=29    exec_time=0     error_code=0
SET TIMESTAMP=1692708954/*!*/;
SET @@session.foreign_key_checks=1/*!*/;
/*!\C utf8mb3 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 9167
#230822 20:55:54 server id 44049365  end_log_pos 9255   Rows_query
# INSERT INTO dbscale.WHITE_USER_INFO VALUES ('admin','%','','139181')
# at 9255
#230822 20:55:54 server id 44049365  end_log_pos 9327   Table_map: `dbscale`.`white_user_info` mapped to number 142
# at 9327
#230822 20:55:54 server id 44049365  end_log_pos 9373   Write_rows: table id 142 flags: STMT_END_F
### INSERT INTO `dbscale`.`white_user_info`
### SET
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='%' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @3='' /* VARSTRING(1536) meta=1536 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 9373
#230822 20:55:54 server id 44049365  end_log_pos 9400   Xid = 301
COMMIT/*!*/;
# at 9400
#230822 20:55:54 server id 44049365  end_log_pos 9475   GTID    last_committed=21       sequence_number=23      rbr_only=yes    original_committed_timestamp=1692708954765139   immediate_commit_timestamp=1692708954765139     transaction_length=470
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1692708954765139 (2023-08-22 20:55:54.765139 CST)
# immediate_commit_timestamp=1692708954765139 (2023-08-22 20:55:54.765139 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708954765139*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:23'/*!*/;
# at 9475
#230822 20:55:54 server id 44049365  end_log_pos 9542   Query   thread_id=29    exec_time=0     error_code=0
SET TIMESTAMP=1692708954/*!*/;
BEGIN
/*!*/;
# at 9542
#230822 20:55:54 server id 44049365  end_log_pos 9704   Rows_query
# REPLACE INTO dbscale.SCHEMA_ACL_INFO (user_name, schema_name, type ,dbscale_cluster_id) VALUES ('admin','_dbscale_reserved_',134217664,139181)
# at 9704
#230822 20:55:54 server id 44049365  end_log_pos 9774   Table_map: `dbscale`.`schema_acl_info` mapped to number 140
# at 9774
#230822 20:55:54 server id 44049365  end_log_pos 9843   Write_rows: table id 140 flags: STMT_END_F
### INSERT INTO `dbscale`.`schema_acl_info`
### SET
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='_dbscale_reserved_' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @3=134217664 /* LONGINT meta=0 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 9843
#230822 20:55:54 server id 44049365  end_log_pos 9870   Xid = 306
COMMIT/*!*/;
# at 9870
#230822 20:56:06 server id 44049365  end_log_pos 9943   GTID    last_committed=23       sequence_number=24      rbr_only=no     original_committed_timestamp=1692708966076292   immediate_commit_timestamp=1692708966076292     transaction_length=232
# original_commit_timestamp=1692708966076292 (2023-08-22 20:56:06.076292 CST)
# immediate_commit_timestamp=1692708966076292 (2023-08-22 20:56:06.076292 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708966076292*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:24'/*!*/;
# at 9943
#230822 20:56:06 server id 44049365  end_log_pos 10102  Query   thread_id=21    exec_time=0     error_code=0    Xid = 508
SET TIMESTAMP=1692708966/*!*/;
SET @@session.foreign_key_checks=0/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%'
/*!*/;
# at 10102
#230822 20:56:06 server id 44049365  end_log_pos 10177  GTID    last_committed=24       sequence_number=25      rbr_only=yes    original_committed_timestamp=1692708966106135   immediate_commit_timestamp=1692708966106135     transaction_length=587
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1692708966106135 (2023-08-22 20:56:06.106135 CST)
# immediate_commit_timestamp=1692708966106135 (2023-08-22 20:56:06.106135 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708966106135*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:25'/*!*/;
# at 10177
#230822 20:56:06 server id 44049365  end_log_pos 10244  Query   thread_id=29    exec_time=0     error_code=0
SET TIMESTAMP=1692708966/*!*/;
SET @@session.foreign_key_checks=1/*!*/;
/*!\C utf8mb3 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 10244
#230822 20:56:06 server id 44049365  end_log_pos 10338  Rows_query
# DELETE FROM dbscale.WHITE_USER_INFO WHERE user_name = 'admin' AND ip = '%'
# at 10338
#230822 20:56:06 server id 44049365  end_log_pos 10410  Table_map: `dbscale`.`white_user_info` mapped to number 142
# at 10410
#230822 20:56:06 server id 44049365  end_log_pos 10456  Delete_rows: table id 142 flags: STMT_END_F
### DELETE FROM `dbscale`.`white_user_info`
### WHERE
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='%' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @3='' /* VARSTRING(1536) meta=1536 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 10456
#230822 20:56:06 server id 44049365  end_log_pos 10544  Rows_query
# INSERT INTO dbscale.WHITE_USER_INFO VALUES ('admin','%','','139181')
# at 10544
#230822 20:56:06 server id 44049365  end_log_pos 10616  Table_map: `dbscale`.`white_user_info` mapped to number 142
# at 10616
#230822 20:56:06 server id 44049365  end_log_pos 10662  Write_rows: table id 142 flags: STMT_END_F
### INSERT INTO `dbscale`.`white_user_info`
### SET
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='%' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @3='' /* VARSTRING(1536) meta=1536 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 10662
#230822 20:56:06 server id 44049365  end_log_pos 10689  Xid = 521
COMMIT/*!*/;
# at 10689
#230822 20:56:09 server id 44049365  end_log_pos 10762  GTID    last_committed=25       sequence_number=26      rbr_only=no     original_committed_timestamp=1692708969250534   immediate_commit_timestamp=1692708969250534     transaction_length=232
# original_commit_timestamp=1692708969250534 (2023-08-22 20:56:09.250534 CST)
# immediate_commit_timestamp=1692708969250534 (2023-08-22 20:56:09.250534 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708969250534*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:26'/*!*/;
# at 10762
#230822 20:56:09 server id 44049365  end_log_pos 10921  Query   thread_id=21    exec_time=0     error_code=0    Xid = 648
SET TIMESTAMP=1692708969/*!*/;
SET @@session.foreign_key_checks=0/*!*/;
/*!\C utf8mb4 *//*!*/;
SET @@session.character_set_client=255,@@session.collation_connection=255,@@session.collation_server=255/*!*/;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%'
/*!*/;
# at 10921
#230822 20:56:09 server id 44049365  end_log_pos 10996  GTID    last_committed=26       sequence_number=27      rbr_only=yes    original_committed_timestamp=1692708969292589   immediate_commit_timestamp=1692708969292589     transaction_length=587
/*!50718 SET TRANSACTION ISOLATION LEVEL READ COMMITTED*//*!*/;
# original_commit_timestamp=1692708969292589 (2023-08-22 20:56:09.292589 CST)
# immediate_commit_timestamp=1692708969292589 (2023-08-22 20:56:09.292589 CST)
/*!80001 SET @@session.original_commit_timestamp=1692708969292589*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= '1e142217-40eb-11ee-b4a2-00163ee6d0aa:27'/*!*/;
# at 10996
#230822 20:56:09 server id 44049365  end_log_pos 11063  Query   thread_id=29    exec_time=0     error_code=0
SET TIMESTAMP=1692708969/*!*/;
SET @@session.foreign_key_checks=1/*!*/;
/*!\C utf8mb3 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=255/*!*/;
BEGIN
/*!*/;
# at 11063
#230822 20:56:09 server id 44049365  end_log_pos 11157  Rows_query
# DELETE FROM dbscale.WHITE_USER_INFO WHERE user_name = 'admin' AND ip = '%'
# at 11157
#230822 20:56:09 server id 44049365  end_log_pos 11229  Table_map: `dbscale`.`white_user_info` mapped to number 142
# at 11229
#230822 20:56:09 server id 44049365  end_log_pos 11275  Delete_rows: table id 142 flags: STMT_END_F
### DELETE FROM `dbscale`.`white_user_info`
### WHERE
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='%' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @3='' /* VARSTRING(1536) meta=1536 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 11275
#230822 20:56:09 server id 44049365  end_log_pos 11363  Rows_query
# INSERT INTO dbscale.WHITE_USER_INFO VALUES ('admin','%','','139181')
# at 11363
#230822 20:56:09 server id 44049365  end_log_pos 11435  Table_map: `dbscale`.`white_user_info` mapped to number 142
# at 11435
#230822 20:56:09 server id 44049365  end_log_pos 11481  Write_rows: table id 142 flags: STMT_END_F
### INSERT INTO `dbscale`.`white_user_info`
### SET
###   @1='admin' /* VARSTRING(192) meta=192 nullable=0 is_null=0 */
###   @2='%' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @3='' /* VARSTRING(1536) meta=1536 nullable=1 is_null=0 */
###   @4=139181 /* INT meta=0 nullable=0 is_null=0 */
# at 11481
#230822 20:56:09 server id 44049365  end_log_pos 11508  Xid = 687
COMMIT/*!*/;
# at 11508
#230822 10:45:46 server id 44049578  end_log_pos 11590  GTID    last_committed=27       sequence_number=28      rbr_only=no     original_committed_timestamp=1692672346267945   immediate_commit_timestamp=1692714078018540     transaction_length=1218
# original_commit_timestamp=1692672346267945 (2023-08-22 10:45:46.267945 CST)
# immediate_commit_timestamp=1692714078018540 (2023-08-22 22:21:18.018540 CST)
/*!80001 SET @@session.original_commit_timestamp=1692672346267945*//*!*/;
/*!80014 SET @@session.original_server_version=80026*//*!*/;
/*!80014 SET @@session.immediate_server_version=80026*//*!*/;
SET @@SESSION.GTID_NEXT= 'e08050aa-4095-11ee-8361-00163e48fc5c:1'/*!*/;

	
	
	
	
	
	
	

```

