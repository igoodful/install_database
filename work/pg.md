







```postgresql
-- docker直接登陆
docker exec -it lhrpg14 psql -U postgres -d postgres

-- 本地登陆
docker exec -it lhrpg14 bash
su - postgres
psql


-- 远程登陆
psql -U postgres -h 192.168.66.35 -d postgres -p54327

-- 从Postgresql 9.2开始，还可以使用URI格式进行远程连接：psql postgresql://myuser:mypasswd@myhost:5432/mydb
psql postgresql://postgres:lhr@192.168.66.35:54327/postgres


其中-h参数指定服务器地址，默认为127.0.0.1，默认不指定即可，-d指定连接之后选中的数据库，默认也是postgres，-U指定用户，默认是当前用户，-p 指定端口号，默认是"5432"，其它更多的参数选项可以执行：./bin/psql --help 查看。





mkdir -p /home/postgres/pg_5433/data
 docker run --restart=always --name pg15   -d -p 5433:5433 -e POSTGRES_PASSWORD=postgres -v /home/postgres/pg_5433/data:/var/lib/postgresql/data -e TZ=Asia/Shanghai postgres:15.4






```



























































