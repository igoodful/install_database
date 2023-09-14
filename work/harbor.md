```bash
# 一、生成CA机构的私钥，命令和生成服务器私钥一样，只不过这是CA的私钥 >> ca.key
openssl genrsa -out ca.key 4096

# 二、生成CA机构自己的证书申请文件 >> ca.crt
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com" -key ca.key -out ca.csr 

# 三、生成自签名证书，CA机构用自己的私钥和证书申请文件生成自己签名的证书，俗称自签名证书，这里可以理解为根证书
# -nodes 表示私钥不加密，若不带参数将提示输入密码；
# x509的含义: 指定格式
# -in的含义: 指定请求文件
# -signkey的含义: 自签名
openssl x509 -req -sha512 -days 3650 -extensions v3_ca -signkey ca.key  -in ca.csr  -out ca.crt

-------------------------------------------------------------------------------------------------------
# 一、生成服务器私钥。nginx中要求的server.key 
openssl genrsa -out server.key 4096

# 二、请求证书。根据服务器私钥文件生成证书请求文件，这个文件中会包含申请人的一些信息，注意: 这一步也会输入参数，要和上一次输入的保持一致
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com" -key server.key -out server.csr

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
openssl x509 -req -sha512 -days 3650 -extensions v3_req -CAserial ca.srl -CAcreateserial -CA ca.crt -CAkey ca.key -in server.csr -out server.crt

---------------------------------------------------------------------------------------
# 生成客户端证书

# 一、生成客户端私钥
openssl genrsa  -out client.key 4096

# 二、申请证书，注意：这一步也会输入参数，要和前两次输入的保持一致 
openssl req -new -sha512 -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com"  -key client.key  -out client.csr 

# 三、使用CA证书签署客户端证书
openssl x509 -req -sha512 -days 3650 -CAcreateserial -in client.csr -CA ca.crt -CAkey ca.key -out client.cer  -extensions v3_req




------------------------------------------------------------------------
# ca证书
openssl req -newkey rsa:2048 -nodes -keyout ca.key -out ca.csr -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com"
# 
openssl x509 -req -days 3650 -in ca.csr -signkey ca.key -out ca.crt

---------------------------------------------------------------------------------
# 服务端
openssl genrsa -out server.key 2048
# 注意: 这一步也会输入参数，要和上一次输入的保持一致
openssl req -new -key server.key -out server.csr -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com"
# 
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 3650

-------------------------------------------------------------------------
# 客户端
openssl genrsa -out client.key 2048
# 注意：这一步也会输入参数，要和前两次输入的保持一致 
openssl req -new  -subj "/C=CN/ST=hubei/L=wuhan/O=igoodful/OU=igoodful/CN=registry.igoodful.com/emailAddress=igoodful@qq.com" -key client.key -out client.csr
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

