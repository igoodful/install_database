







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





# PostgreSQL 16.0

```bash
./configure --help

# GNU make 3.81+，作用：编译源码
 make --version
 cmake
 gcc
 gcc-c++
 ncurses-devel
 # tar gzip bzip2，作用：解压PostgreSQL的安装包
yum -y install tar
yum -y install gzip
yum -y install bzip2

# readline and readline-devel，作用：命令自动补全
# Bash中，Ctrl-A，行首。 Ctrl-E 行末。 Ctrl-U 删除该行中光标之前的所有内容。
yum -y install readline
yum -y install readline-devel
# 查看是否存在动态链接库libreadline.so
ldconfig -p |grep readline
# 阻止使用 Readline 库（以及 libedit）。 这选项禁用 psql 中的命令行编辑和历史记录
--without-readline

# zlib
# 阻止使用 Zlib 库。 这会禁用对pg_dump 和 pg_restore中的压缩档案。
--without-zlib
yum -y install zlib
yum -y install zlib-devel
# icu pkg-config ICU4C 4.6+
# 构建时不支持 ICU 库，禁用 ICU整理功能。
--without-icu
yum -y install libicu-devel
# PL/Perl Perl 5.14+
--with-perl
yum -y install perl
yum -y install perl-IPC-Run
# PL/Python Python 3.2+
# PL/Python 将是一个共享库，因此“libpython”库必须是共享库,当源码安装python时，必须使用--enable-shared配置python
--with-python
yum -y install python311/python36
# PL/Tcl Tcl 8.4+
--with-tcl
yum -y install tcl
# OpenSSL 1.0.1+
--with-openssl
yum -y install openssl
# LZ4
--with-lz4


# Zstandard 1.4.0+ 使用 Zstandard 压缩支持进行构建。
--with-zstd

# git 
# Flex 2.5.35+
# Bison 2.3+

# 启用本机语言支持 (NLS)，即能够显示一个
--enable-nls


--with-systemd

# OpenLDAP
--with-ldap
yum -y install openldap
# 使用 PAM（可插入身份验证模块）支持进行构建
--with-pam
yum -y install pam
# 使用 libxml2 构建，启用 SQL/XML 支持。 Libxml2 版本 2.6.23+
# pkg-config
--with-libxml

# 使用 libxslt 构建，使 xml2 模块能够执行 XSL XML 的转换。 还必须指定“--with-libxml”
--with-libxslt

# --with-includes=DIRECTORIES：“DIRECTORIES”是一个以冒号分隔的目录列表，添加到编译器搜索头文件的列表中。 
# 如果你已安装可选软件包（例如 GNU Readline）非标准位置，您必须使用此选项，也可能相应的“--with-libraries”选项。
--with-includes=DIRECTORIES
--with-includes=/opt/gnu/include:/usr/sup/include


# “DIRECTORIES”是一个以冒号分隔的要搜索的目录列表 图书馆。 您可能必须使用此选项（并且相应的“--with-includes”选项）
# 如果您有软件包安装在非标准位置。
--with-libraries=目录
--with-libraries=/opt/gnu/lib:/usr/sup/lib

# 将“NUMBER”设置为服务器和客户端的默认端口号。 这 默认值为 5432。以后可以随时更改该端口，
# 但如果您在这里指定，那么服务器和客户端将具有相同的 默认编译进去，非常方便。 
# 通常是唯一的选择非默认值的充分理由是如果您打算运行同一台机器上有多个 PostgreSQL 服务器。
--with-pgport=NUMBER

# 设置段大小（以 GB 为单位）。 大表分为多个操作系统文件，每个文件的大小等于段尺寸。 
# 这避免了许多计算机上存在的文件大小限制问题平台。 默认段大小 1 GB 对所有设备都是安全的支持的平台。
# 如果您的操作系统有“largefile”支持（现在大多数都这样做），您可以使用更大的段尺寸。 
# 这有助于减少文件描述符的数量使用非常大的表时消耗。 但要注意不要选择一个大于您的平台支持的值您打算使用的文件系统。 
# 您可能希望使用的其他工具，例如 tar，还可以设置可用文件大小的限制。 这是建议（尽管不是绝对要求）该值是2 的幂。
# 请注意，更改此值会破坏磁盘数据库兼容性，这意味着您不能使用“pg_upgrade”升级到使用不同的段大小进行构建。
--with-segsize=SEGSIZE

# 设置块大小（以千字节为单位）。 这是存储单位表内的 I/O。 默认值 8 KB，适合大多数人情况； 
# 但在特殊情况下其他值可能有用。 这值必须是 1 到 32（千字节）之间的 2 的幂。 
# 注意更改此值会破坏磁盘数据库兼容性，这意味着您不能使用“pg_upgrade”升级到具有不同版本的版本块大小。
--with-blocksize=BLOCKSIZE

# 设置 WAL 块大小（以千字节为单位）。 这是存储单位以及 WAL 日志中的 I/O。 默认值 8 KB 是合适的对于大多数情况； 
# 但其他值在特殊情况下可能有用案例。 该值必须是 1 到 64（千字节）之间的 2 的幂。
# 请注意，更改此值会破坏磁盘数据库兼容性，意味着你不能使用“pg_upgrade”升级到带有不同的 WAL 块大小。
--with-wal-blocksize=BLOCKSIZE

# 构建将用于在内部开发代码的安装时服务器，建议至少使用以下选项；在服务器中启用断言检查
--enable-debug
--enable-cassert


# 环境变量，这些环境变量中最常用的是 CC 和 CFLAGS
# CC环境变量，会覆盖默认的C编译器
#CFLAGS环境变量，会覆盖默认的编译器标志
export CC=/opt/bin/gcc
export CFLAGS='-O2 -pipe'
./configure
# 或者如下指定
./configure CC=/opt/bin/gcc CFLAGS='-O2 -pipe'

# Bison program
BISON
#  C compiler
CC
# 传递给 C 编译器的选项
CFLAGS
# 用于处理内联源代码的“clang”程序的路径使用 --with-llvm 编译时
CLANG
# C预处理器
CPP
# 传递给 C 预处理器的选项
CPPFLAGS
# C++编译器
CXX
# 传递给 C++ 编译器的选项
CXXFLAGS
# “dtrace”程序的位置
DTRACE
# 传递给“dtrace”程序的选项
DTRACEFLAGS
# Flex program
FLEX
# 链接可执行文件或共享库时使用的选项
LDFLAGS
# 仅用于链接可执行文件的附加选项
LDFLAGS_EX
# 仅用于链接共享库的附加选项
LDFLAGS_SL
# “llvm-config”程序用于定位 LLVM 安装
LLVM_CONFIG
# Perl 解释程序。 这将用于确定构建 PL/Perl 的依赖项。 默认值为“perl”
PERL
# python 解释程序。 这将用于确定构建 PL/Python 的依赖项。 如果未设置此项，则按此顺序探测以下内容：python3 python
PYTHON
# Tcl 解释程序。 这将用于确定构建 PL/Tcl 的依赖项。 如果没有设置，则如下
# 按以下顺序进行探测：tclsh tcl tclsh8.6 tclsh86 tclsh8.5 tclsh85 tclsh8.4 tclsh84
TCLSH
# “xml2-config”程序用于定位 libxml2 安装
XML2_CONFIG








```





```bash
echo "LD_LIBRARY_PATH=/home/work/pg_5432/lib" >> /etc/profile
echo "export LD_LIBRARY_PATH" >> /etc/profile
echo "PATH=\$PATH:/home/work/pg_5432/bin" >> /etc/profile
ldconfig /home/work/pg_5432/lib


/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data


/usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data



```

/usr/local/pgsql/bin/createdb testdb



```
1wget https://ftp.postgresql.org/pub/source/v16.0/postgresql-16.0.tar.gz
  2
  3-- 创建用户
  4groupadd -g 60000 pgsql
  5useradd -u 60000 -g pgsql pgsql
  6echo "lhr" | passwd --stdin pgsql
  7
  8
  9-- 创建目录
 10mkdir -p /postgresql/{pgdata,archive,scripts,backup,pg16,soft}
 11chown -R pgsql:pgsql /postgresql
 12chmod -R 775 /postgresql
 13
 14
 15
 16-- 安装一些依赖包
 17yum install -y cmake make gcc zlib gcc-c++ perl readline readline-devel zlib zlib-devel \
 18perl python36 tcl openssl ncurses-devel openldap pam perl-IPC-Run libicu-devel
 19
 20
 21-- 编译
 22su - pgsql
 23cd /postgresql/soft
 24tar zxvf postgresql-16.0.tar.gz
 25cd postgresql-16.0
 26./configure --prefix=/postgresql/pg16
 27make -j 8 && make install
 28make world -j 8 && make install-world
 29
 30
 31
 32-- 配置环境变量
 33cat >>  ~/.bash_profile <<"EOF"
 34export LANG=en_US.UTF-8
 35export PS1="[\u@\h \W]\$ "
 36export PGPORT=5432
 37export PGDATA=/postgresql/pgdata
 38export PGHOME=/postgresql/pg16
 39export LD_LIBRARY_PATH=$PGHOME/lib:/lib64:/usr/lib64:/usr/local/lib64:/lib:/usr/lib:/usr/local/lib:$LD_LIBRARY_PATH
 40export PATH=$PGHOME/bin:$PATH:.
 41export DATE=`date +"%Y%m%d%H%M"`
 42export MANPATH=$PGHOME/share/man:$MANPATH
 43export PGHOST=$PGDATA
 44export PGUSER=postgres
 45export PGDATABASE=postgres
 46EOF
 47
 48source  ~/.bash_profile
 49
 50
 51
 52-- 初始化
 53su - pgsql
 54/postgresql/pg16/bin/initdb -D /postgresql/pgdata -E UTF8 --locale=en_US.utf8 -U postgres --data-checksums
 55
 56
 57
 58-- 修改参数
 59cat >> /postgresql/pgdata/postgresql.conf <<"EOF"
 60listen_addresses = '*'
 61port=5432
 62unix_socket_directories='/postgresql/pgdata'
 63logging_collector = on
 64log_directory = 'pg_log'
 65log_filename = 'postgresql-%a.log'
 66log_truncate_on_rotation = on
 67EOF
 68
 69cat   >> /postgresql/pgdata/pg_hba.conf << EOF
 70# TYPE  DATABASE    USER    ADDRESS       METHOD
 71local     all       all                    trust
 72host      all       all   127.0.0.1/32     trust
 73host      all       all    0.0.0.0/0        md5
 74host   replication  all    0.0.0.0/0        md5
 75EOF
 76
 77-- 启动
 78su - pgsql
 79pg_ctl start
 80pg_ctl status
 81pg_ctl stop
 82
 83-- 修改密码
 84pg_ctl start 
 85psql
 86alter user postgres with  password 'lhr';
 87exit
 88
 89
 90-- 或：
 91nohup /postgresql/pg13/bin/postgres -D /postgresql/pgdata > /postgresql/pg13/pglog.out 2>&1 &
 92
 93
 94
 95
 96-- 配置系统服务
 97cat > /etc/systemd/system/PG16.service <<"EOF"
 98[Unit]
 99Description=PostgreSQL database server
100Documentation=man:postgres(1)
101After=network.target
102
103[Service]
104Type=forking
105User=pgsql
106Group=pgsql
107Environment=PGPORT=5432
108Environment=PGDATA=/postgresql/pgdata
109OOMScoreAdjust=-1000
110ExecStart=/postgresql/pg16/bin/pg_ctl start -D ${PGDATA} -s -o "-p ${PGPORT}" -w -t 300
111ExecStop=/postgresql/pg16/bin/pg_ctl stop -D ${PGDATA} -s -m fast
112ExecReload=/postgresql/pg16/bin/pg_ctl reload -D ${PGDATA} -s
113KillMode=mixed
114KillSignal=SIGINT
115TimeoutSec=0
116
117[Install]
118WantedBy=multi-user.target
119EOF
120
121
122
123systemctl daemon-reload
124systemctl enable PG16
125systemctl start PG16
126systemctl status PG16
```











































