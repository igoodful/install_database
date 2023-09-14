

# 简介

ansible依赖大量的python模块来实现批量管理，需要有python环境: python2.6/2.7/3.x



```shell
rpm -qc ansible
/etc/ansible/ansible.cfg  # 主配置文件
/etc/ansible/hosts #主机清单文件
```



# 安装

```shell
ansible --version





```



# 一、modules



1.  使用多个模块
2.  按照一定的顺序
3.  组合在一起



1.  comman/shell模块 远程执行命令或脚本模块
2.  copy模块发送文件到远程主机模块
3.  yum模块远程安装软件(相当于到远端机器执行yum -y install xxx
4.  service模块：远程管理服务启停模块
5.  script模块：本地编写脚本，到远程主机执行
6.  file模块：远程传目录或文件，做软连接等
7.  group模块：远程创建和管理用户组
8.  user模块：远程创建和管理用户
9.  cron模块：远程添加定时任务
10.  mount模块：远程添加挂载
11.  get_url模块：远程下载文件
12.  systemd模块：通过systemd来管理服务启停,类似systemctl start httpd远程控制
13.  selinux模块
14.  setup模块：开启或关闭主机信息模块，获取主机的信息

```BASH
# 

















```



# 二、yaml

多个play组成

```









```





# playbook

1.  一个task就是要执行的动作。包含名称、参数、描述
2.  多个task就是一个tasks
3.  在什么主机hosts，上什么用户user，执行什么操作tasks，这统称为一个play
4.  建议：为每个play设置一个名称





```bash






```







# tasks

任务

```

```





# hosts

表示这些任务在哪里执行

```
-







```



# remote_user

表示以哪个用户身份执行

```yaml
- hosts: database
  remote_user: root
  vars:
    tablename: foo
    tableowner: someuser



```



# vars



```
vars:
  sb: yes

{{sb}}
```





# inventory

参与执行任务的所有节点

```
[web]
10.10.10.11
10.10.10.12
[database]
10.10.10.21
10.10.10.22



```



















