```bash
# 一、生成CA机构的私钥，命令和生成服务器私钥一样，只不过这是CA的私钥 >> ca.key
openssl genrsa -out ca.key 4096

# 二、生成CA机构自己的证书申请文件 >> ca.crt
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com" -key ca.key -out ca.csr 

# 三、生成自签名证书，CA机构用自己的私钥和证书申请文件生成自己签名的证书，俗称自签名证书，这里可以理解为根证书
# -nodes 表示私钥不加密，若不带参数将提示输入密码；
# x509的含义: 指定格式
# -in的含义: 指定请求文件
# -signkey的含义: 自签名
# -extensions v3_req 指定 X.509 v3版本
# -extensions v3_ca 生成CA扩展名
# -extfile /tmp/openssl.conf 指定特殊的配置文件
openssl x509 -req -sha512 -days 3650 -extfile /etc/pki/tls/openssl.cnf -extensions v3_req -extensions v3_ca -signkey ca.key  -in ca.csr  -out ca.crt



# 查看证书内容：
openssl x509 -in ca.crt -text -noout

[root@node196 tmp]# openssl x509 -in ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            8d:ce:4a:0d:49:2f:b5:f7
    Signature Algorithm: sha512WithRSAEncryption
        Issuer: C=CN, ST=hubei, L=wuhan, O=igoodful, OU=igoodful, CN=registry.igoodful.com/emailAddress=igoodful@qq.com
        Validity
            Not Before: Aug 31 00:48:27 2023 GMT
            Not After : Aug 28 00:48:27 2033 GMT
        Subject: C=CN, ST=hubei, L=wuhan, O=igoodful, OU=igoodful, CN=registry.igoodful.com/emailAddress=igoodful@qq.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (4096 bit)
                Modulus:
                    00:ae:0f:d1:d4:cd:c3:16:0d:e9:da:0f:32:e3:51:
                    6f:4a:d6:bb:f2:76:04:61:fd:dc:a7:10:9a:bb:4d:
                    ad:61:48:56:0a:bd:d3:a3:d2:d1:4b:3c:ef:c2:ae:
                    01:de:b1:bb:52:d9:f5:f0:40:33:ae:90:ab:5c:d0:
                    ac:76:4e:1e:10:79:30:c4:9e:8c:fe:06:46:57:5f:
                    88:59:8b:c5:40:8a:85:5f:89:7f:3d:2a:00:04:fd:
                    61:a0:7a:83:ac:0e:2d:8a:7a:58:c9:f5:0b:72:0d:
                    92:e4:70:2d:6a:a1:6f:9b:45:e8:ff:95:1a:9b:5e:
                    76:1a:d9:1e:1a:2f:6b:42:0d:38:c8:21:7a:3e:0f:
                    1e:54:9a:5f:90:c3:73:8f:e6:57:38:1b:08:e2:f3:
                    94:29:cc:45:98:a6:c9:45:30:7f:5f:e7:a5:df:25:
                    1c:bb:ee:90:e9:b8:17:36:80:8d:6d:92:da:0a:c4:
                    26:ee:d5:ec:35:5c:b4:21:23:00:37:b9:c8:e5:c8:
                    59:18:bc:dc:51:5d:99:8f:0a:67:0f:9d:77:3d:2f:
                    1b:66:52:d9:17:bd:fe:ce:08:2c:f9:ee:92:d6:68:
                    6e:0a:24:3a:d3:0f:93:60:db:cd:47:96:29:41:67:
                    7b:65:ed:5e:a8:6d:9f:b7:40:82:d6:c0:14:0b:3e:
                    df:25:e9:86:0e:c5:13:b9:3b:e7:87:aa:2e:e8:a4:
                    dd:2d:a2:6b:58:90:e8:78:74:1d:0c:24:69:6d:e2:
                    f4:d3:3c:54:29:08:57:f5:d5:32:8e:0e:dd:45:c5:
                    8b:51:6d:18:e5:2a:ab:90:0f:bb:d1:e6:2c:a1:ff:
                    2f:e0:ba:4c:98:d1:f6:b8:ad:cf:2e:95:64:f2:c6:
                    79:b1:1d:b0:7e:41:04:01:8f:1c:12:a7:45:28:f5:
                    12:23:bc:66:53:3e:62:10:ac:60:3b:29:2f:38:58:
                    07:60:b8:88:14:bf:57:31:9e:7a:cd:ca:36:0a:7d:
                    c2:9c:b8:38:0d:b2:a8:66:3e:9c:8b:34:41:05:da:
                    1f:8b:d1:87:a0:5c:30:98:3a:fb:bb:0a:19:af:6f:
                    8f:d8:0b:89:4a:1c:b8:b6:b3:46:b0:87:e6:44:8f:
                    75:0a:bb:25:7b:a6:2a:ff:54:88:1c:fc:f0:45:88:
                    88:89:f6:d5:77:31:43:96:fb:cc:d3:1b:2f:bb:8b:
                    62:30:40:9d:64:dd:24:f3:d4:e9:ac:36:27:27:6d:
                    76:1b:40:5b:a5:56:09:ae:cf:7d:6c:8e:2f:42:49:
                    77:16:ea:94:3a:d5:a4:bb:ec:47:83:da:c9:d4:b1:
                    fd:84:95:38:e6:74:e7:2e:49:44:6d:59:5a:53:28:
                    b8:8c:91
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Subject Key Identifier: 
                28:AA:40:DC:A4:DA:E2:61:85:32:E1:E9:A8:D4:69:85:D3:A7:E4:EB
            X509v3 Authority Key Identifier: 
                keyid:28:AA:40:DC:A4:DA:E2:61:85:32:E1:E9:A8:D4:69:85:D3:A7:E4:EB

            X509v3 Basic Constraints: 
                CA:TRUE
    Signature Algorithm: sha512WithRSAEncryption
         a5:81:ae:aa:eb:c6:e0:67:69:f6:13:2c:ca:89:06:7e:56:46:
         e4:58:6b:cc:88:9e:f2:3b:1c:69:c4:2c:52:76:c4:02:b3:32:
         b6:e0:d8:28:46:76:ca:52:fa:5c:2d:97:30:2a:b5:01:de:21:
         d3:fe:a1:81:18:5e:6b:dc:81:cf:4f:98:d3:64:f4:b2:3b:e0:
         7e:22:e3:b7:ed:f5:de:89:2b:d0:fe:b4:29:ad:8c:61:fa:a3:
         b8:10:33:a0:3e:d8:8b:54:a4:c6:65:ec:9a:22:91:88:54:47:
         7d:97:64:a4:ea:01:09:dc:89:ae:38:4a:e9:ee:a5:9e:fa:4c:
         e2:f9:0e:c3:a5:98:56:9c:bf:76:75:08:47:19:f6:f7:5e:1c:
         80:23:19:32:77:d4:ea:f7:3b:42:0e:a2:82:ce:be:cf:f3:34:
         11:3d:02:2e:47:84:f8:86:71:07:ca:c8:84:15:98:b4:7e:ed:
         51:e5:7e:44:20:2e:ad:b8:9f:a5:10:1d:5c:e6:93:c1:a1:bd:
         0e:86:3b:0a:2f:b6:22:8e:4c:6b:b4:ea:82:1c:55:23:e0:09:
         2d:a8:6c:67:6c:72:e7:84:34:b7:a6:37:e1:c9:ce:ac:35:08:
         70:dd:b0:bf:eb:da:d4:71:aa:a2:c4:37:b2:f6:df:1e:33:9f:
         32:6a:83:7d:34:88:6d:35:52:88:06:f4:01:a5:8e:13:cc:03:
         d7:eb:21:78:73:93:22:32:7e:fe:88:54:98:3d:50:7b:eb:d3:
         d8:ae:58:15:01:c8:bb:62:73:0f:89:4c:b3:24:40:fd:ce:81:
         15:1d:5d:cc:74:ef:9a:40:08:a0:f0:cd:61:01:05:fd:9b:cf:
         ea:5c:48:1c:e6:b5:44:cb:ff:50:0e:42:48:e1:ae:66:cd:44:
         b4:19:81:c4:fb:75:a4:3f:d9:54:dc:fc:00:3f:55:4a:4c:6c:
         89:32:8f:97:89:a7:41:04:20:83:d9:52:fe:10:1b:9c:63:36:
         aa:58:17:21:86:b3:31:d9:bc:51:5a:91:1d:90:ba:91:07:41:
         07:5f:93:ae:22:ea:c6:b6:37:67:cc:85:05:ed:36:33:fe:32:
         f2:11:83:7b:4e:21:75:b8:eb:23:c0:f9:3a:db:04:d6:7a:e9:
         82:bd:1b:08:5b:9f:4e:b6:99:7f:99:93:d6:08:e1:32:7c:69:
         a2:21:16:57:41:48:50:5c:c7:96:b8:8f:64:59:6b:ab:1d:77:
         3d:d1:fe:06:be:12:0b:c6:2b:6a:5e:d9:fd:eb:d3:00:e6:04:
         0c:8b:eb:09:03:76:b7:0b:d1:76:c1:75:05:27:51:86:b4:a5:
         c8:9e:48:47:81:86:ef:da
[root@node196 tmp]# 

-------------------------------------------------------------------------------------------------------
# 一、生成服务器私钥。nginx中要求的server.key 
openssl genrsa -out server.key 4096

# 二、请求证书。根据服务器私钥文件生成证书请求文件，这个文件中会包含申请人的一些信息，注意: 这一步也会输入参数，要和上一次输入的保持一致
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com" -key server.key -out server.csr

# 三、使用CA证书签署服务器证书。根据CA机构的自签名证书ca.crt或者叫根证书生、CA机构的私钥ca.key、服务器的证书申请文件server.csr生成服务端证书
# 请求证书，nginx中要求的server.crt
# 证数各参数含义如下
# C 国家 Country Name
# ST----省份 State or Province Name
# L----城市 Locality Name
# O----公司 Organization Name
# OU----部门 Organizational Unit Name
# CN----产品名 Common Name
# emailAddress----邮箱  Email Address
cat > v3.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage=digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage=serverAuth
subjectAltName=@alt_names

[alt_names]
DNS.1=harbor.igoodful.com
DNS.2=harbor.igoodful
EOF

openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CAcreateserial -CA ca.crt -CAkey ca.key -in server.csr -out server.crt
# 四、将 server.crt 转为 server.cert 以供docker使用
openssl x509 -inform PEM -in server.crt -out server.cert

# docker配置https
mkdir -p  /etc/docker/certs.d/harbor.igoodful.com/
cp ca.crt server.key server.cert   /etc/docker/certs.d/harbor.igoodful.com/
# 配置为 server.key server.crt
vim harbor.yml
# certificate: /home/work/harbor/keys/server.crt
# private_key: /home/work/harbor/keys/server.key

# shi
docker login harbor.igoodful.com
docker pull nginx
docker tag nginx harbor.igoodful.com/igoodful/nginx:latest
docker push harbor.igoodful.com/igoodful/nginx:latest


# PEM格式是证书颁发机构颁发证书的最常见格式.PEM证书通常具有扩展名，例如.pem，.crt，.cer和.key。它们是Base64编码的ASCII文件，包含“----- BEGIN CERTIFICATE -----”和“----- END CERTIFICATE -----”语句。

# DER格式只是证书的二进制形式，而不是ASCII PEM格式。它有时会有.der的文件扩展名，但它的文件扩展名通常是.cer所以判断DER .cer文件和PEM .cer文件之间区别的唯一方法是在文本编辑器中打开它并查找BEGIN / END语句。所有类型的证书和私钥都可以用DER格式编码。DER通常与Java平台一起使用。

#转换crt为cert，
openssl x509 -inform PEM -in server.crt -out server.cert
# der 转 pem
openssl x509 -inform  der -in server.cer -out server.pem
# pem 转 der
openssl x509 -outform der -in server.pem -out server.der
---------------------------------------------------------------------------------------
# 生成客户端证书

# 一、生成客户端私钥
openssl genrsa  -out client.key 4096

# 二、申请证书，注意：这一步也会输入参数，要和前两次输入的保持一致 
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com"  -key client.key  -out client.csr 

# 三、使用CA证书签署客户端证书
openssl x509 -req -sha512 -days 3650 -CAcreateserial -in client.csr -CA ca.crt -CAkey ca.key -out client.cer  -extensions v3_req




------------------------------------------------------------------------
# ca证书
openssl req -newkey rsa:2048 -nodes -keyout ca.key -out ca.csr -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com"
# 
openssl x509 -req -days 3650 -in ca.csr -signkey ca.key -out ca.crt

---------------------------------------------------------------------------------
# 服务端
openssl genrsa -out server.key 2048
# 注意: 这一步也会输入参数，要和上一次输入的保持一致
openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com"
# 
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650

-------------------------------------------------------------------------
# 客户端
openssl genrsa -out client.key 2048
# 注意：这一步也会输入参数，要和前两次输入的保持一致 
openssl req -new  -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=harbor.igoodful.com/emailAddress=igoodful@qq.com" -key client.key -out client.csr
#
openssl x509 -req -days 3650 -CAcreateserial -in client.csr -CA ca.crt -CAkey ca.key -out client.crt







# 配置示例（Nginx）：
server {
        listen       80;
	    listen       443 ssl;
        server_name  172.21.10.101;
	    ssl_certificate /opt/server.crt;
    	ssl_certificate_key /opt/server.key;
	    if ($scheme = http) {
           return 301 https://$host$uri?$args;
        }
 
        #charset koi8-r;
        #access_log  logs/host.access.log  main;
 
        location / {
            #root   html;
            #index  index.html index.htm;
            proxy_pass http://172.xx.xx.xx:9000/xxx/xxx/;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }

# 配置示例（Apache）：
<VirtualHost *:443>
    ServerName example.com
    SSLEngine on
    SSLCertificateFile /path/to/server.crt
    SSLCertificateKeyFile /path/to/server.key
    SSLCACertificateFile /path/to/ca.crt
    ...
</VirtualHost>

# 配置示例（Tomcat）：
<Connector port="8443" protocol="HTTP/1.1" SSLEnabled="true"
           maxThreads="150" scheme="https" secure="true"
           keystoreFile="/path/to/server.keystore" keystorePass="password"
           truststoreFile="/path/to/ca.crt" truststorePass="password"
           clientAuth="true" sslProtocol="TLS"/>
           
           
```

## PEM

-   适用于Apache、Nginx、Candy Server等Web服务器
-   常见的文件后缀为.pem、.crt、.cer、.key
-   可以存放证书或私钥，或者两者都包含
-   .key后缀一般只用于证书私钥文件



## PFX

-   适用于IIS等Web服务器
-   常见的文件后缀为.pfx、.p12
-   同时包含证书和私钥，且一般有密码保护

## JKS

-   适用于Tomcat、Weblogic、JBoss、Jetty等Web服务器
-   常见的文件后缀为.jks



















