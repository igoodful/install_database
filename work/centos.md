





# 常用安装包

```shell
# net-tools  包含了netstat命令






yum -y install nfs-utils
# cat /etc/exports
/data *(rw,no_root_squash)


# 
systemctl status nfs
systemctl restart nfs
echo "111" > /data/a.txt




```



## playbook.yaml

```yaml
# notify 触发
# vars：变量


- hosts: test
  remote_user: root
  gather_facts: no
  vars:
    src_nginx: /data/nginx.tar.gz
    nginx_targz: nginx.tar.gz
    nginx_dir: /data/nginx
    nginx_install_dir: /data/nginx_8080
  tasks:
    - name: mount nfs
      mount: src=172.17.135.193:/data path=/data fstype=nfs opts=defaults state=mounted
    - name: install rsync
      yum: name=rsync,gcc,gcc-c++,openssl,zlib,zlib-devel state=installed
    - name: un rsync
      unarchive: 
        src: '{{ nginx_targz }}'
        dest: '{{ nginx_dir }}'
    - name: config, make, make install 
      shell: ./configure && make && make install     
    - name: copy rsync.conf
      copy: src=./rsync.conf dest=/etc/rsync.conf
      notify: Restart Rsync Server
    - name: create user and password 
      copy: content='work:work' dest=/etc/rsyncd.password mode=600
    - name: add group
      group: name=www gid=666
    - name: add user
      user: name=www uid=666 group=www create_home=yes shell=/bin/bash
    - name: add directory
      file: path=/data state=directory owner=www group=www mode=755 recurse=yes
    - name: start rsyncd
      service: name=rsyncd state=started enabled=yes
  handlers:
    - name: Restart Rsync Server
      service: name=rsyncd state=restarted


# cat /etc/fstab

```





```bash
# ansible-palybook my.yaml -v





```











```yaml
# 变量

# handler

# task

# 
playbook-all-roles.yaml # 总控
host
	hosts  # 与/etc/ansible/hosts一样
roles # 所有roles的目录，名称不能改
	mysql # 名称可改
		default # 一般不使用，优先级比var低，名称不能改
		files # 名称不能改
			my.cnf # 角色部署时，默认的文件存放目录
		handlers # 名称不能改
			main.yaml # 触发重启的任务
		meta # 一般用不到，名称不能改
		tasks # 名称不能改
			main.yaml # 控制任务的执行顺序，名称不能改
			install_mysql.yaml
			service.yaml
		vars # 名称不能改
			main.yaml # 定义变量
		templates # 名称不能改
	redis
	pg
	mongodb
	nginx
	http
	tomcat





```















































