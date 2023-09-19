

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-client-provisioner
  labels:
    app: nfs-client-provisioner
spec:
  replicas: 1
  strategy: 
    type: Recreate
  selector:
    matchLabels:
      app: nfs-client-provisioner
  template:
    metadata:
      labels:
        app: nfs-client-provisioner
    spec:
      serviceAccountName: nfs-client-provisioner
      containers:
      - name: nfs-client-provisioner
        image: registry.cn-beijing.aliyuncs.com/mydlq/nfs-subdir-external-provisioner:v4.0.0
        volumeMounts:
        - name: nfs-client-root
          mountPath: /persistentvolumes
        env:
        - name: PROVISIONER_NAME
          value: nfs-client 
        - name: NFS_SERVER
          value: 172.17.135.193
        - name: NFS_PATH
          value: /nfs/data
      volumes:
      - name: nfs-client-root
        nfs:
          server: 172.17.135.193
          path: /nfs/data








apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs-storage
  annotations:
    storageclass.kubernetes.io/is-default-class: "false"  
provisioner: nfs-client
parameters:
  archiveOnDelete: "true"
mountOptions: 
  - hard
  - nfsvers=4


kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-pvc
spec:
  storageClassName: nfs-storage
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Mi






apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  capacity:          
    storage: 50Gi
  accessModes:       
  - ReadWriteOnce
  mountOptions:
  - hard
  - nfsvers=4.1    
  nfs:
    server: 172.17.135.193
    path: /nfs/data       
  persistentVolumeReclaimPolicy: Retain  
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql
spec:
  resources:
    requests:
      storage: 50Gi
  accessModes:
  - ReadWriteOnce
  selector:
    matchLabels:
      app: mysql




apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  type: NodePort
  ports:
  - name: mysql
    port: 3306
    targetPort: 3306
    nodePort: 30336
  selector:
    app: mysql
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql
  labels:
    app: mysql
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
        image: mysql:8.0.19
        ports:
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "123456"
        resources:
          limits:
            cpu: 2000m
            memory: 512Mi
          requests:
            cpu: 2000m
            memory: 512Mi
        livenessProbe:
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
          exec:
            command: ["mysqladmin", "-uroot", "-p${MYSQL_ROOT_PASSWORD}", "ping"]
        readinessProbe:  
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          successThreshold: 1
          failureThreshold: 3
          exec:
            command: ["mysqladmin", "-uroot", "-p${MYSQL_ROOT_PASSWORD}", "ping"]
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
        - name: config
          mountPath: /etc/mysql/conf.d/my.cnf
          subPath: my.cnf
        - name: localtime
          readOnly: true
          mountPath: /etc/localtime
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: mysql
      - name: config      
        configMap:
          name: mysql-config
      - name: localtime
        hostPath:
          type: File
          path: /etc/localtime




```



## yaml文件特殊符号

```yaml
|控制符
| 这个控制符的作用是保留文本每一行尾部的换行符。

|会保证整段文本最后有且只有一个换行符；使用|+可以保留整段文本最后的所有换行符；使用|-可以删除整段文本最后的所有换行符。

# --------"|"示例begin--------
# YAML格式
key: |
  a
  b
  c
 
 
nextKey: ...
# 实际效果
"key": "a\nb\nc\n"
# ---------"|"示例end---------
 
# --------"|+"示例begin--------
# YAML格式
key: |+
  a 
  b
  c
   
  
nextKey: ...
# 实际效果
"key": "a\nb\nc\n\n\n"
# ---------"|+"示例end---------
 
# --------"|-"示例begin--------
# YAML格式
key: |-
  a
  b
  c
   
  
nextKey: ...
# 实际效果
"key": "a\nb\nc"
# ---------"|-"示例end---------
>控制符
>这个控制符的作用是将每一行尾部的换行符替换为空格，也就是将多行文本视为一行。

>会保证文本最后有且只有一个换行符。使用>+可以保留文本最后的所有换行符，使用>-可以删除文本最后的所有换行符。

# --------">"示例begin--------
# YAML格式
key: >
  a
  b
  c
 
 
nextKey: ...
# 实际效果
"key": "a b c\n"
# ---------">"示例end---------
 
# --------">+"示例begin--------
# YAML格式
key: >+
  a
  b
  c
   
  
nextKey: ...
# 实际效果
"key": "a b c\n\n\n"
# ---------">+"示例end---------
 
# --------">-"示例begin--------
# YAML格式
key: >-
  a
  b
  c
   
  
nextKey: ...
# 实际效果
"key": "a\nb\nc"
# ---------">-"示例end---------

```



```bash
# 在部署节点上安装nfs
yum -y install nfs-utils

# 创建nfs挂载目录
mkdir -p /nfs/mysql

#增加nfs配置
echo '/nfs/mysql *(rw,sync,no_root_squash)' >> /etc/exports

#重启nfs服务
systemctl restart rpcbind.service
systemctl restart nfs-utils.service 
systemctl restart nfs-server.service 

# 增加NFS-SERVER开机自启动
systemctl enable nfs-server.service 

# 验证NFS-SERVER是否能正常访问
showmount -e 10.10.10.90
# 输出是下面这样就成功
# Export list for 10.10.10.90:
# /net/mysql *


```



```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nfs-client-provisioner
  namespace: kube-system

---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: nfs-client-provisioner-runner
rules:
  - apiGroups: [""]
    resources: ["persistentvolumes"]
    verbs: ["get", "list", "watch", "create", "delete"]
  - apiGroups: [""]
    resources: ["persistentvolumeclaims"]
    verbs: ["get", "list", "watch", "update"]
  - apiGroups: ["storage.k8s.io"]
    resources: ["storageclasses"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["events"]
    verbs: ["list", "watch", "create", "update", "patch"]
  - apiGroups: [""]
    resources: ["endpoints"]
    verbs: ["create", "delete", "get", "list", "watch", "patch", "update"]

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: run-nfs-client-provisioner
subjects:
  - kind: ServiceAccount
    name: nfs-client-provisioner
    namespace: kube-system
roleRef:
  kind: ClusterRole
  name: nfs-client-provisioner-runner
  apiGroup: rbac.authorization.k8s.io

---
kind: Deployment
apiVersion: apps/v1
metadata:
  name: nfs-provisioner-01
  namespace: kube-system
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: nfs-provisioner-01
  template:
    metadata:
      labels:
        app: nfs-provisioner-01
    spec:
      serviceAccountName: nfs-client-provisioner
      containers:
        - name: nfs-client-provisioner
          image: vbouchaud/nfs-client-provisioner:latest
          imagePullPolicy: IfNotPresent
          volumeMounts:
            - name: nfs-client-root
              mountPath: /persistentvolumes
          env:
            - name: PROVISIONER_NAME
              value: nfs-provisioner-01  # 此处供应者名字供storageclass调用
            - name: NFS_SERVER
              value: 10.10.10.90   # 填入NFS的地址
            - name: NFS_PATH
              value: /nfs/mysql   # 填入NFS挂载的目录
      volumes:
        - name: nfs-client-root
          nfs:
            server: 10.10.10.90   # 填入NFS的地址
            path: /nfs/mysql   # 填入NFS挂载的目录

---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: nfs
provisioner: nfs-provisioner-01
# Supported policies: Delete、 Retain ， default is Delete
reclaimPolicy: Retain

####################################################################


# Secret 为 mysql集群配置密码
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  labels:
    app: mysql
type: Opaque # Opaque类型，data里面的值必须填base64加密后的内容
data:
  password: Y1dAY3do # base64加密后的密码 echo -n 'cW@cwh' |base64



#######################################################################

apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql
  labels:
    app: mysql
data:
  primary.cnf: |
    # 主节点应用这个配置
    [mysqld]
    log-bin
    default_authentication_plugin= mysql_native_password
  replica.cnf: |
    # 从节点应用这个配置
    [mysqld]
    super-read-only
    default_authentication_plugin= mysql_native_password



########################################################################

# Headless service for stable DNS entries of StatefulSet members.
apiVersion: v1
kind: Service
metadata:
  name: mysql
  labels:
    app: mysql
spec:
  clusterIP: None
  ports:
  - port: 3306
  selector:
    app: mysql
---
# Client service for connecting to any MySQL instance for reads.
# For writes, you must instead connect to the primary: mysql-0.mysql.
apiVersion: v1
kind: Service
metadata:
  name: mysql-read
  labels:
    app: mysql
spec:
  ports:
  - port: 3306
    nodePort: 30036
  selector:
    app: mysql
  type: NodePort
---
# 提供外部连接主节点
apiVersion: v1
kind: Service
metadata:
  name: mysql-readwrite
  labels:
    app: mysql
spec:
  ports:
  - name: mysql
    port: 3306
    nodePort: 30306
  selector:
    statefulset.kubernetes.io/pod-name: mysql-0 
  type: NodePort





#################################################

apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  selector:
    matchLabels:
      app: mysql
  serviceName: mysql
  replicas: 3
  template:
    metadata:
      labels:
        app: mysql
    spec:
      initContainers:
        - name: init-mysql
          image: mysql:8.0.18
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
          command:
            - bash
            - "-c"
            - |
              set -ex
              # 从 Pod 的序号，生成 server-id
              [[ `hostname` =~ -([0-9]+)$ ]] || exit 1
              ordinal=${BASH_REMATCH[1]}
              echo [mysqld] > /mnt/conf.d/server-id.cnf
              # 由于 server-id 不能为 0 ，因此给 ID 加 100 来避开它
              echo server-id=$((100 + $ordinal)) >> /mnt/conf.d/server-id.cnf
              # 如果 Pod 的序号为 0 ，说明它是 Master 节点，从 ConfigMap 里把 Master 的配置文件拷贝到 /mnt/conf.d 目录下
              # 否则，拷贝 ConfigMap 里的 Slave 的配置文件
              if [[ $ordinal -eq 0 ]]; then
                cp /mnt/config-map/primary.cnf /mnt/conf.d/
              else
                cp /mnt/config-map/replica.cnf /mnt/conf.d/
              fi
          volumeMounts:
            - name: conf
              mountPath: /mnt/conf.d
            - name: config-map
              mountPath: /mnt/config-map
        - name: clone-mysql
          image: jstang/xtrabackup:2.3
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
          command:
            - bash
            - "-c"
            - |
              set -ex
              # 拷贝操作只需要在第一次启动时进行，所以数据已经存在则跳过
              [[ -d /var/lib/mysql/mysql ]] && exit 0
              # Master 节点（序号为 0 ）不需要这个操作
              [[ $(hostname) =~ -([0-9]+)$ ]] || exit 1
              ordinal=${BASH_REMATCH[1]}
              [[ $ordinal == 0 ]] && exit 0
              # 使用 ncat 指令，远程地从前一个节点拷贝数据到本地
              ncat --recv-only mysql-$(($ordinal-1)).mysql 3307 | xbstream -x -C /var/lib/mysql
              # 执行 --prepare ，这样拷贝来的数据就可以用作恢复了
              xtrabackup --prepare --target-dir=/var/lib/mysql
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
              subPath: mysql
            - name: conf
              mountPath: /etc/mysql/conf.d
      containers:
        - name: mysql
          image: mysql:8.0.18
          env:
            # - name: MYSQL_ALLOW_EMPTY_PASSWORD
            # value: "1"
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
          ports:
            - name: mysql
              containerPort: 3306
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
              subPath: mysql
            - name: conf
              mountPath: /etc/mysql/conf.d
          resources:
            requests:
              cpu: 500m
              memory: 1Gi
          livenessProbe:
            exec:
              command:
                - /bin/sh
                - "-c"
                - MYSQL_PWD="${MYSQL_ROOT_PASSWORD}"
                - mysqladmin ping
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
          readinessProbe:
            exec:
              # Check we can execute queries over TCP (skip-networking is off).
              command:
                - /bin/sh
                - "-c"
                - MYSQL_PWD="${MYSQL_ROOT_PASSWORD}"
                - mysql -h 127.0.0.1 -u root -e "SELECT 1"
            initialDelaySeconds: 5
            periodSeconds: 2
            timeoutSeconds: 1
        - name: xtrabackup
          image: jstang/xtrabackup:2.3
          ports:
            - name: xtrabackup
              containerPort: 3307
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: mysql-secret
                  key: password
          command:
            - bash
            - "-c"
            - |
              set -ex
              cd /var/lib/mysql

              # 从备份信息文件里读取 MASTER_LOG_FILE 和 MASTER_LOG_POS 这 2 个字段的值，用来拼装集群初始化 SQL
              if [[ -f xtrabackup_slave_info ]]; then
                # 如果 xtrabackup_slave_info 文件存在，说明这个备份数据来自于另一个 Slave 节点
                # 这种情况下，XtraBackup 工具在备份的时候，就已经在这个文件里自动生成了 "CHANGE MASTER TO" SQL 语句
                # 所以，只需要把这个文件重命名为 change_master_to.sql.in，后面直接使用即可
                mv xtrabackup_slave_info change_master_to.sql.in
                # 所以，也就用不着 xtrabackup_binlog_info 了
                rm -f xtrabackup_binlog_info
              elif [[ -f xtrabackup_binlog_info ]]; then
                # 如果只是存在 xtrabackup_binlog_info 文件，说明备份来自于 Master 节点，就需要解析这个备份信息文件，读取所需的两个字段的值
                [[ $(cat xtrabackup_binlog_info) =~ ^(.*?)[[:space:]]+(.*?)$ ]] || exit 1
                rm xtrabackup_binlog_info
                # 把两个字段的值拼装成 SQL，写入 change_master_to.sql.in 文件
                echo "CHANGE MASTER TO MASTER_LOG_FILE='${BASH_REMATCH[1]}',\
                      MASTER_LOG_POS=${BASH_REMATCH[2]}" > change_master_to.sql.in
              fi
              # 如果存在 change_master_to.sql.in，就意味着需要做集群初始化工作
              if [[ -f change_master_to.sql.in ]]; then
                # 但一定要先等 MySQL 容器启动之后才能进行下一步连接 MySQL 的操作
                echo "Waiting for mysqld to be ready（accepting connections）"
                until mysql -h 127.0.0.1 -uroot -p${MYSQL_ROOT_PASSWORD} -e "SELECT 1"; do sleep 1; done
                echo "Initializing replication from clone position"
                # 将文件 change_master_to.sql.in 改个名字
                # 防止这个 Container 重启的时候，因为又找到了 change_master_to.sql.in，从而重复执行一遍初始化流程
                mv change_master_to.sql.in change_master_to.sql.orig
                # 使用 change_master_to.sql.orig 的内容，也就是前面拼装的 SQL，组成一个完整的初始化和启动 Slave 的 SQL 语句
                mysql -h 127.0.0.1 -uroot -p${MYSQL_ROOT_PASSWORD} << EOF
              $(< change_master_to.sql.orig),
                MASTER_HOST='mysql-0.mysql-headless',
                MASTER_USER='root',
                MASTER_PASSWORD='${MYSQL_ROOT_PASSWORD}',
                MASTER_CONNECT_RETRY=10;
              START SLAVE;
              EOF
              fi
              # 使用 ncat 监听 3307 端口。
              # 它的作用是，在收到传输请求的时候，直接执行 xtrabackup --backup 命令，备份 MySQL 的数据并发送给请求者
              exec ncat --listen --keep-open --send-only --max-conns=1 3307 -c \
                "xtrabackup --backup --slave-info --stream=xbstream --host=127.0.0.1 --user=root --password=${MYSQL_ROOT_PASSWORD}"
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
              subPath: mysql
            - name: conf
              mountPath: /etc/mysql/conf.d
          resources:
            requests:
              cpu: 100m
              memory: 100Mi
      volumes:
        - name: conf
          emptyDir: {}
        - name: config-map
          configMap:
            name: mysql
  volumeClaimTemplates:
    - metadata:
        name: data
        annotations: 
          volume.beta.kubernetes.io/storage-class: nfs # 对应第2步创建的 StorageClass 的名称
      spec:
        accessModes: ["ReadWriteOnce"]
        # storageClassName: "nfs" 不能这样写，需要在 annotations 字段传入，原因未知
        resources:
          requests:
            storage: 1Gi







```







```
apiVersion: v1
kind: Pod
metadata:
  name: dapi-test-pod
spec:
  containers:
    - name: test-container
      image: registry.k8s.io/busybox
      command: [ "/bin/sh", "-c", "env" ]
      env:
        - name: SPECIAL_LEVEL_KEY
          valueFrom:
            configMapKeyRef:
              name: special-config
              key: special.how
  restartPolicy: Never
```





### mysql-config.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  labels:
    app: mysql
data:
  my.cnf: |-
    [client]
    default-character-set = utf8mb4
    [mysql]
    default-character-set = utf8mb4
    [mysqld]
    port = 3308
    server_id = 1001503308
    skip_name_resolve = 1
    skip_slave_start = 1
    skip_external_locking = 1
    binlog_format = row
    character_set_server = utf8mb4
    default_authentication_plugin = mysql_native_password
    log_slave_updates = 1
    gtid_mode = on
    enforce_gtid_consistency = on
    innodb_buffer_pool_size = 1G
    long_query_time = 1
    lower_case_table_names = 1
    master_info_repository = TABLE
    max_allowed_packet = 16M
    max_connections = 20480
    max_prepared_stmt_count = 1048576
    net_read_timeout = 10000
    net_write_timeout = 10000
    wait_timeout = 31536000
    open_files_limit = 800000
    sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION





```







```yaml
# 创建 Kubernetes 的 ConfigMap 资源，用于存储 Mysql 的配置文件 my.cnf 内容：
# [root@master glc]#  kubectl get cm mysql-config -n igoodful -o yaml
apiVersion: v1
data:
  my.cnf: |-
    [client]
    default-character-set = utf8mb4
    [mysql]
    default-character-set = utf8mb4
    [mysqld]
    port = 3308
    server_id = 1001503308
    skip_name_resolve = 1
    skip_slave_start = 1
    skip_external_locking = 1
    binlog_format = row
    character_set_server = utf8mb4
    default_authentication_plugin = mysql_native_password
    log_slave_updates = 1
    gtid_mode = on
    enforce_gtid_consistency = on
    innodb_buffer_pool_size = 1G
    long_query_time = 1
    lower_case_table_names = 1
    master_info_repository = TABLE
    max_allowed_packet = 16M
    max_connections = 20480
    max_prepared_stmt_count = 1048576
    net_read_timeout = 10000
    net_write_timeout = 10000
    wait_timeout = 31536000
    open_files_limit = 800000
    sql_mode=STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
kind: ConfigMap
metadata:
  creationTimestamp: "2023-09-16T07:10:17Z"
  labels:
    app: mysql
  name: mysql-config
  namespace: igoodful
  resourceVersion: "2261376"
  selfLink: /api/v1/namespaces/igoodful/configmaps/mysql-config
  uid: 8e9b3a5c-cc16-4d27-b75b-c39f3f37ebf4

```





### mysql-pv.yaml

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
  labels:
    app: mysql 
spec:
  capacity:
    storage: 100Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  storageClassName: slow
  nfs:
    server: 172.17.135.193
    path: /nfs/data
```





### mysql-pvc.yaml

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-pvc
  namespace: igoodful
spec:
  accessModes: 
  - ReadWriteMany 
  selector:
    matchLabels:
      app: mysql
  storageClassName: slow
  resources:
    requests:
      storage: 50Gi
```







```bash
ansible test -m shell -a 'setenforce 0'

ansible test -m selinux -a 'state=disabled'


ansible test -m shell -a 'cat /etc/hosts'
```













