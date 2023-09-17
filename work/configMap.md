

























```
ConfigMap是Kubernetes 在1.2版本中引入的功能
为什么使用ConfigMap ?
在使用命令的时候注意单词： configmap等价于cm，cm算是简写，类似于deployment可以使用命令时写成deploy，service可以写成svc，namespace可以写成ns，pod可以写成po。
https://blog.csdn.net/liumiaocn/article/details/103818799


动态配置管理


创建ConfigMap的方式
常见的创建方式有如下4种：

使用--from-literal选项在命令行中直接创建
使用--from-file选项指定配置文件创建
使用--from-file选项指定目录进行创建
使用-f选项指定标准的ConfigMap的yaml文件进行创建
```

https://www.cnblogs.com/larrydpk/p/14947993.html

![img](https://img2020.cnblogs.com/other/946674/202106/946674-20210628234005207-1197338894.png)







# 二、管理

## 查询

```bash
# 查询缺省的default命名空间的ConfigMap信息
kubectl get configmap
kubectl get cm

# 指定命名空间
kubectl get configmap -n 命名空间名称
kubectl get cm -n 命名空间名称
# 查询所有命令空间的ConfigMap信息
kubectl get configmap -A
kubectl get cm -A
```





## 创建



### （1）使用--from-literal选项在命令行中直接创建

```bash
kubectl create configmap mysql-configmap-literal --from-literal=user.name=liumiao --from-literal=user.id=1001

[root@host131 config]#

# 创建
[root@k8s-master ~]# kubectl create configmap user-configmap --from-literal=id=1001 --from-literal=name=zhangsan --from-literal=age=30 
configmap/user-configmap created
[root@k8s-master ~]# kubectl get configmap
NAME               DATA   AGE
kube-root-ca.crt   1      17d
user-configmap     3      9s
[root@k8s-master ~]# kubectl describe configmap user-configmap
Name:         user-configmap
Namespace:    myq
Labels:       <none>
Annotations:  <none>

Data
====
age:
----
30
id:
----
1001
name:
----
zhangsan

BinaryData
====

Events:  <none>

[root@k8s-master ~]# kubectl delete configmap user-configmap
configmap "user-configmap" deleted

########################
[root@k8s-master glc]# cat user 
id=200
name=wangwu
age=20
[root@k8s-master glc]# kubectl create configmap user-configmap  --from-file=user
configmap/user-configmap created
[root@k8s-master glc]# kubectl get cm
NAME               DATA   AGE
kube-root-ca.crt   1      17d
user-configmap     1      13s
[root@k8s-master glc]# kubectl describe configmap user-configmap
Name:         user-configmap
Namespace:    myq
Labels:       <none>
Annotations:  <none>

Data
====
user:
----
id=100
name=zhangsan
age=30


BinaryData
====

Events:  <none>
################################## yaml文件
# 数字不要
# cat user-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: user-configmap
data:
  id: '100'
  name: zhangsan
  age: '30'

# kubectl create -f user-configmap.yaml



#  

```



| id   | 100      |
| ---- | -------- |
| name | zhangsan |
| age  | 30       |



### （2）使用--from-file选项指定配置文件创建









### （3）使用--from-file选项指定目录进行创建





### （4）使用-f选项指定标准的ConfigMap的yaml文件进行创建









## 查看



```bash
# 查询缺省的default命名空间的ConfigMap信息
kubectl get cm

# 查询指定命令空间的ConfigMap信息
kubectl get cm -n igoodful

# 查询所有命令空间的ConfigMap信息
kubectl get cm -A

# yaml格式输出
kubectl get cm  user-configmap -o yaml



```





## 修改





```bash
# kubectl edit configmap ConfigMap名称



# 直接更改yaml文件里面的值，通过
# kubectl apply -f configmap-test01.yaml
# 重新发布一遍进行更新。










```





## 删除



```bash
# 通过yaml文件的方式删除
$ kubectl delete -f configmap-test01.yaml

# 直接删除资源 kubectl delete configmap ConfigMap名称
$ kubectl delete cm cm-test01





```







#  三、使用



```bash
# 容器应用对ConfigMap的使用主要是两种：
1）通过环境变量获取ConfigMap的内容：spec.env和spec.envFrom
2）通过卷volume挂载的方式将ConfigMap的内容挂载到容器内部的文件或目录：spec.volumes
在Pod中使用ConfigMap有以下四种方式：
1 在容器命令和参数内
2 容器的环境变量
3 在只读卷里面添加一个文件，让应用来读取
4 编写代码在 Pod 中运行，使用 Kubernetes API 来读取 ConfigMap
其中第1种和第2种方式类似，只是启动命令添加环境变量，所以还是要把ConfigMap映射为容器的环境变量。
第4种方式要访问API，可以使用相关的库，如Spring Cloud Kubernetes，这里不再介绍。
所以我们主要讲解第2、3种方式。
```





## spec.env：

```yaml
#  vim pod-test01.yaml
apiVersion: v1
kind: Pod
metadata:
  name: cm-pod-test001
spec:
  containers:
  - name: cm-test
    image: tomcat:8
    command: [ "/bin/sh", "-c", "env | grep APP"]
    env:
    - name: APPCONF01 		# 定义环境变量的名称
      valueFrom:	  		# key “appconf01”的值获取
        configMapKeyRef:
          name: cm-test01	# 环境变量的值来自于configmap cm-test01
          key: appconf01	# configmap中的配置key为appconf01
    - name: APPCONF02		# 定义环境变量的名称
      valueFrom:			# key “appconf02”的值获取
        configMapKeyRef:
          name: cm-test01	# 环境变量的值来自于configmap cm-test01
          key: appconf02	# configmap中的配置key为appconf02
  restartPolicy: Never		# 重启策略：从不。

```



```json
{
    "apiVersion":"v1",
    "kind":"Pod",
    "metadata":{
        "name":"cm-pod-test001"
    },
    "spec":{
        "containers":[
            {
                "name":"cm-test",
                "image":"tomcat:8",
                "command":[
                    "/bin/sh",
                    "-c",
                    "env | grep APP"
                ],
                "env":[
                    {
                        "name":"APPCONF01",
                        "valueFrom":{
                            "configMapKeyRef":{
                                "name":"cm-test01",
                                "key":"appconf01"
                            }
                        }
                    },
                    Object{...}
                ]
            }
        ],
        "restartPolicy":"Never"
    }
}
```



```
kubectl create -f pod-test01.yaml

kubectl get pods

kubectl logs cm-pod-test001

kubectl exec -it redis -- redis-cli
```









## spec.envFrom



```yaml
# [root@k8s /cm/test]#  vim pod-test02.yaml
apiVersion: v1
kind: Pod
metadata:
  name: cm-pod-test002
spec:
  containers:
  - name: cm-test2
    image: tomcat:8
    command: [ "/bin/sh", "-c", "env"]
    envFrom:
    - configMapRef:
      name: cm-test01	# 根据ConfigMap cm-test01资源自动生成环境变量
  restartPolicy: Never


# 注意：环境变量的名称受限制：[a-zA-Z][a-zA-Z0-9_]*，不能以数字或非法字符开头。
```



```bash
 kubectl create -f pod-test02.yaml
 
 kubectl get pods
```



## valueFrom一一映射

NOTE：当然也可以把`application-uat.yaml`这种文件映射成环境变量，但因为文件内容可能是多行的，我们一般不会这样做。





## envFrom全部映射



显然看起来这种方式更简便，不用每个环境变量都配一遍，但它可能会带来脏数据，就看怎么使用了。





## volume加载



```yaml
# [root@k8s /cm/test]#  vim pod-test03.yaml
# 指定items
apiVersion: v1
kind: Pod
metadata:
  name: cm-pod-test003
spec:
  containers:
  - name: cm-test3
    image: tomcat:8
    volumeMounts:
    - name: vm-01-1
      mountPath: /conf
  volumes:
  - name: vm-01-1
    configMap:
      name: cm-test-file
      items:
      - key: key-testproperties
        path: test.properties
  restartPolicy: Never

```





```yaml
# [root@k8s /cm/test]#  vim pod-test04.yaml
# 不指定items
apiVersion: v1
kind: Pod
metadata:
  name: cm-pod-test004
spec:
  containers:
  - name: cm-test4
    image: tomcat:8
    volumeMounts:
    - name: vm-02-2
      mountPath: /conf
  volumes:
  - name: vm-02-2
    configMap:
      name: cm-test-file
  restartPolicy: Never

```





```bash
# 列出所有命名空间下的所有容器镜像
kubectl get pods --all-namespaces -o jsonpath="{.items[*].spec.containers[*].image}" |tr -s '[[:space:]]' '\n' |sort |uniq -c

# 按 Pod 列出容器镜像 
kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' | sort
```







## subPath加载



```
cat  << EOF > pg_hba.conf
TYPE  DATABASE    USER    ADDRESS       METHOD
local     all       all                    trust
host      all       all    ::1/128         trust
host      all       all   127.0.0.1/32     trust
host      all       all    0.0.0.0/0        md5
host   replication  all    0.0.0.0/0        md5
EOF
```



# 应用



## 一、mysql使用confimap

https://juejin.cn/post/7254039378195628089

### mysql-configmap.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
data:
  my.cnf: |
    [mysqld]
    server-id=1
    datadir=/var/lib/mysql
    # 其他 MySQL 配置选项

```



### mysql-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:latest
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: your-password
        volumeMounts:
        - name: mysql-config-volume
          mountPath: /etc/mysql/conf.d
      volumes:
      - name: mysql-config-volume
        configMap:
          name: mysql-config

```



### 检验

```bash


[root@master glc]# kubectl get pods
NAME                     READY   STATUS      RESTARTS   AGE
cm-pod-glc               0/1     Completed   0          24h
mysql-66d47db76b-jmz9f   1/1     Running     0          9m15s
redis                    1/1     Running     0          93m
[root@master glc]# kubectl exec -it mysql-66d47db76b-jmz9f -- /bin/bash
root@mysql-66d47db76b-jmz9f:/# mysql -uroot -p'your-password'
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.27 MySQL Community Server - GPL

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| igoodful           |
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
5 rows in set (0.01 sec)

mysql> 




```





### redis案例

redis-pvc.yaml

```yaml
# docker pull sameersbn/redis:4.0.9-3
apiVersion: v1
kind: PersistentVolume
metadata:
  name: redis
  labels:
    app: redis
spec:
  capacity:          
    storage: 5Gi
  accessModes:       
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  mountOptions:
  - hard
  - nfsvers=4.1
  nfs:               
    server: 172.17.135.193
    path: /nfs/redis      
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: redis
spec:
  resources:
    requests:
      storage: 5Gi      
  accessModes:
  - ReadWriteOnce
  selector:
    matchLabels:
      app: redis

```



 **redis-deploy.yaml**

```yaml
## Service
kind: Service
apiVersion: v1
metadata:
  name: gitlab-redis
  labels:
    name: gitlab-redis
spec:
  type: ClusterIP
  ports:
    - name: redis
      protocol: TCP
      port: 6383
      targetPort: redis
  selector:
    name: gitlab-redis
---
kind: Deployment
apiVersion: apps/v1
metadata:
  name: gitlab-redis
  labels:
    name: gitlab-redis
spec:
  replicas: 1
  selector:
    matchLabels:
      name: gitlab-redis
  template:
    metadata:
      name: gitlab-redis
      labels:
        name: gitlab-redis
    spec:
      containers:
      - name: gitlab-redis
        image: 'sameersbn/redis:4.0.9-3'
        ports:
        - name: redis
          containerPort: 6383
          protocol: TCP
        resources:
          limits:
            cpu: 1000m
            memory: 2Gi
          requests:
            cpu: 1000m
            memory: 2Gi
        volumeMounts:
          - name: data
            mountPath: /var/lib/redis
        livenessProbe:
          exec:
            command:
              - redis-cli
              - ping
          initialDelaySeconds: 5
          timeoutSeconds: 5
          periodSeconds: 10
          successThreshold: 1
          failureThreshold: 3
        readinessProbe:
          exec:
            command:
              - redis-cli
              - ping
          initialDelaySeconds: 5
          timeoutSeconds: 5
          periodSeconds: 10
          successThreshold: 1
          failureThreshold: 3
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: redis



# kubectl exec -it gitlab-redis-594d7cccd7-lppdg -n igoodful -- redis-cli
# kubectl exec -it gitlab-redis-594d7cccd7-lppdg -n igoodful -- bash
# kubectl get svc -n igoodful
# kubectl get deploy -n igoodful
# kubectl get pvc -n igoodful
# kubectl get pv -n igoodful
```



















