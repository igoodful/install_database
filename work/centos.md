



```bash

yum -y install go
yum -y install npm
yum -y install git

yum -y install hugo
npm install --save-dev autoprefixer
npm install --save-dev postcss-cli
npm install -D postcss



hugo server --bind 0.0.0.0




hugo new site quickstart
cd quickstart
git init
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke











```



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





## 头文件

### 1、系统默认的头文件搜索路径：echo | cpp -Wp,-v 2>&1 |grep "^ /"

```bash
# 打印系统默认的头文件搜索路径
echo | cpp -Wp,-v
echo | gcc -E -Wp,-v -

[root@192 install_database]# echo | cpp -Wp,-v
ignoring nonexistent directory "/opt/rh/devtoolset-8/root/usr/lib/gcc/x86_64-redhat-linux/8/include-fixed"
ignoring nonexistent directory "/opt/rh/devtoolset-8/root/usr/lib/gcc/x86_64-redhat-linux/8/../../../../x86_64-redhat-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 /opt/rh/devtoolset-8/root/usr/lib/gcc/x86_64-redhat-linux/8/include
 /usr/local/include
 /opt/rh/devtoolset-8/root/usr/include
 /usr/include
End of search list.
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "<stdin>"

###################################################################
# 如下写法最佳：
[root@192 install_database]# echo | cpp -Wp,-v 2>&1 |grep "^ /"
 /opt/rh/devtoolset-8/root/usr/lib/gcc/x86_64-redhat-linux/8/include
 /usr/local/include
 /opt/rh/devtoolset-8/root/usr/include
 /usr/include

# 查找指定头文件是否在默认头文件搜索路径中
find $(echo | cpp -Wp,-v 2>&1 |grep "^ /") -name  gnumake.h
```



### 2、编译器选项：-I

如果你使用的函数或变量所在的头文件不在默认路径中，那么你就需要给编译器指定搜索路径

```bash
# 如果 Readline 的头文件不在默认路径中，但位于 /path/to/readline/include，你可以使用以下命令编译代码：
gcc -o my_program my_program.c -I/path/to/readline/include -lreadline -lhistory



```



### 3、环境变量：C_INCLUDE_PATH，CPLUS _INCLUDE_PATH

```bash
# 编译器会搜索这个环境变量中指定的路径
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/path/to/readline/include:/path/to/myreadline/include



```



总之，编译器会按照上述规则来查找头文件，其中包括默认路径、编译器选项和环境变量。通常情况下：

1.  系统默认的头文件搜索路径会包括常用的头文件，因此大多数标准库和常见库的头文件可以被找到。
2.  如果头文件不在默认路径中，你可以使用编译器选项或环境变量来指定其路径。



### 4、项目目录中的头文件：

编译器会在项目目录中查找头文件。这意味着如果你的源文件与头文件在同一目录中，编译器会自动找到它们

```



```



当源文件与头文件位于同一目录中时，编译器会自动查找并找到这些头文件，无需额外的路径指定。让我通过一个简单的示例来说明这一点：

假设你有以下两个文件在同一目录中：

1. `my_program.c` - C源代码文件
2. `my_header.h` - 头文件

`my_program.c` 可能如下所示：

```c
#include <stdio.h>
#include "my_header.h"

int main() {
    printMessage();
    return 0;
}
```

`my_header.h` 可能如下所示：

```c
#ifndef MY_HEADER_H
#define MY_HEADER_H

void printMessage();

#endif
```

在这个示例中，`my_program.c` 包含了 `<stdio.h>` 标准头文件以及自定义头文件 `"my_header.h"`。注意，自定义头文件的引用使用双引号而不是尖括号。

当你使用编译器编译 `my_program.c` 时，不需要指定额外的路径，因为编译器会自动查找当前目录中的头文件。例如，使用以下命令编译：

```shell
gcc -o my_program my_program.c
```

编译器会在当前目录中查找 `my_header.h`，并将其与 `my_program.c` 一起编译成可执行文件 `my_program`。

这种自动查找同一目录中的头文件的机制使得在项目中组织源代码和头文件更加方便，无需为每个头文件都指定路径。只需确保源文件和相关的头文件位于同一目录中，编译器就能够正确找到它们。

## 头文件写法

在C和C++中，`#include` 指令用于包含头文件，但有两种不同的方式来包含头文件，它们之间有一些区别：

1. **`#include "my_header.h"`：**
   - 使用双引号括起头文件名，例如 `"my_header.h"`。
   - 编译器首先会在当前源文件所在目录查找头文件，如果找到则包含它。
   - 如果在当前目录找不到头文件，编译器将会搜索系统的标准头文件路径。
   - 这种方式适合用于包含项目内的自定义头文件或在项目中有自定义的头文件组织结构。
   
2. **`#include <my_header.h>`：**

   - 使用尖括号括起头文件名，例如 `<my_header.h>`。
   - 编译器只会搜索系统的标准头文件路径，而不会在当前目录中查找。
   - 这种方式通常用于包含标准库头文件或第三方库的头文件，而不是项目内的自定义头文件。

总结来说，区别在于双引号方式会首先在当前目录中查找头文件，而尖括号方式仅搜索系统标准头文件路径。通常情况下：

- 如果你要包含自己项目内的头文件，使用 `#include "my_header.h"` 形式更合适，因为它允许你在项目中自由组织头文件并将它们包含到源文件中。

- 如果你要包含标准库的头文件或第三方库的头文件，应该使用 `#include <header.h>` 形式，因为这样可以确保编译器在系统标准头文件路径中找到这些头文件。

在实践中，你需要根据具体情况选择适当的 `#include` 形式，以确保编译器能够正确地找到并包含所需的头文件。





