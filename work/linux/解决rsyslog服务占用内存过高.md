









## 一、现象



```bash
# 报错如下：
Message from syslogd@master at Sep 18 20:32:02 ...
 kernel:NMI watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [kube-controller:7491]

Message from syslogd@master at Sep 18 20:32:24 ...
 kernel:NMI watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [rootwrap:6671]

# 使用top命令查看内存占用时，发现rsyslogd内存占用很高。
[root@adm254 ~]# top
top - 15:35:28 up 1 min,  1 user,  load average: 6.64, 1.97, 0.68
Tasks: 169 total,   9 running, 160 sleeping,   0 stopped,   0 zombie
%Cpu(s): 73.4 us, 25.7 sy,  0.0 ni,  0.1 id,  0.0 wa,  0.7 hi,  0.1 si,  0.0 st
MiB Mem :   7581.4 total,   3497.4 free,   2304.9 used,   1779.1 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   4189.2 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                                                                                              
   1217 root      20   0  698880  78400  72576 S  91.4   1.0   0:48.24 rsyslogd                                                                                                             
   1218 root      20   0  784320  70848  47360 S  48.5   0.9   0:16.39 promtail                                                                                                             
   2277 root      20   0  176960 160960  18496 R  32.9   2.1   0:15.38 gunicorn                                                                                                             
   2278 root      20   0  177280 161024  18496 R  32.2   2.1   0:15.94 gunicorn                                                                                                             
   2334 root      20   0   63040  52736   7296 R  32.2   0.7   0:02.09 gunicorn                                                                                                             
   2276 root      20   0  178688 160896  18496 R  31.9   2.1   0:16.72 gunicorn                                                                                                             
   2333 root      20   0   74944  68352   7296 R  30.2   0.9   0:02.35 gunicorn                                                                                                             
   2279 root      20   0  177536 161024  18496 R  25.9   2.1   0:15.92 gunicorn                                                                                                             
   2332 root      20   0   53376  43136   7296 R  19.6   0.6   0:01.61 gunicorn                                                                                                             
   2331 root      20   0   54144  43200   7296 R  16.9   0.6   0:02.13 gunicorn                                                                                                             
   2228 root      20   0 1529856  87488  54528 S   9.6   1.1   0:04.02 grafana-server                                                                                                       
   2225 root      20   0  831104 128704  43008 S   7.6   1.7   0:05.14 loki                                                                                                                 
   2226 root      20   0  390208  89088  14976 S   7.6   1.1   0:06.85 python                                                                                                               
   2249 root      20   0  755200  84352  13952 S   7.3   1.1   0:07.28 python                                                                                                               
     10 root      20   0       0      0      0 I   0.3   0.0   0:00.33 rcu_sched                                                                                                            
     33 root      20   0       0      0      0 I   0.3   0.0   0:00.63 kworker/2:1-events                                                                                                   
   2233 root      20   0  729216  30016  18304 S   0.3   0.4   0:00.97 alertmanager                                                                                                         
      1 root      20   0  173504  16832   8896 S   0.0   0.2   0:04.81 systemd                                                                                                              
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.02 kthreadd                                                                                                             
      3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp                                                                                                               
      4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_par_gp                                                                                                           
      5 root      20   0       0      0      0 I   0.0   0.0   0:00.01 kworker/0:0-cgroup_pidlist_destroy                                                                                   
      6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/0:0H-kblockd                                                                                                 
      7 root      20   0       0      0      0 I   0.0   0.0   0:00.18 kworker/u8:0-flush-8:0                                                                                               
      8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 mm_percpu_wq                                                                                                         
      9 root      20   0       0      0      0 S   0.0   0.0   0:00.06 ksoftirqd/0                                                                                                          
     11 root      20   0       0      0      0 I   0.0   0.0   0:00.00 rcu_bh                                                                                                               
     12 root      rt   0       0      0      0 S   0.0   0.0   0:00.02 migration/0                                                                                                          
     13 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/0                                                                                                              
     14 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/1                                                                                                              
     15 root      rt   0       0      0      0 S   0.0   0.0   0:00.03 migration/1                                                                                                          
     16 root      20   0       0      0      0 S   0.0   0.0   0:00.02 ksoftirqd/1                                                                                                          
     17 root      20   0       0      0      0 I   0.0   0.0   0:00.00 kworker/1:0-cgroup_pidlist_destroy                                                                                   
     18 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 kworker/1:0H-kblockd                                                                                                 
     19 root      20   0       0      0      0 S   0.0   0.0   0:00.00 cpuhp/2                                                                                                              
     20 root      rt   0       0      0      0 S   0.0   0.0   0:00.02 migration/2                                                                                                          
     21 root      20   0       0      0      0 S   0.0   0.0   0:00.05 ksoftirqd/2         
```



kubectl create cm literal-config --from-literal=name=very --from-literal=age=charm





## 解决

-   系统当前默认的rsyslog.service内容

```bash
[root@adm254 ~]# cat /usr/lib/systemd/system/rsyslog.service
[Unit]
Description=System Logging Service
;Requires=syslog.socket
Documentation=man:rsyslogd(8)
Documentation=https://www.rsyslog.com/doc/

[Service]
Type=notify
ExecStart=/usr/sbin/rsyslogd -n -iNONE
StandardOutput=null
Restart=on-failure

# Increase the default a bit in order to allow many simultaneous
# files to be monitored, we might need a lot of fds.
LimitNOFILE=16384
[Install]
WantedBy=multi-user.target
;Alias=syslog.service

```



-   新增MemoryHigh=8M和MemoryMax=80M

```bash
[Unit]
Description=System Logging Service
;Requires=syslog.socket
Wants=network.target network-online.target
After=network.target network-online.target
Documentation=man:rsyslogd(8)
Documentation=http://www.rsyslog.com/doc/
 
[Service]
Type=notify
EnvironmentFile=-/etc/sysconfig/rsyslog
ExecStart=/usr/sbin/rsyslogd -n $SYSLOGD_OPTIONS
Restart=on-failure
UMask=0066
StandardOutput=null
Restart=on-failure
MemoryAccounting=yes
MemoryMax=80M
MemoryHigh=8M
 
[Install]
WantedBy=multi-user.target
;Alias=syslog.service
```





















