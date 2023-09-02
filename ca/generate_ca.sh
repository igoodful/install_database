#!/bin/bash
# 如果使用FQDN连接Harbor主机，则必须将其指定为通用名称（CN）属性，因此该名称就写为CN
C='CN'
# ST表示省份，这里写为湖北
ST='hubei'
# L表示城市，这里写为武汉
L='wuhan'
# O表示公司名称
O='apple'
# OU表示部门
OU='igoodful'
# emailAddress表示你的邮箱
emailAddress='igoodful@qq.com'
# CN表示你的域名，就是我们的核心目标，比如你的网站是https://www.google.com，那么这里的CN就是www.google.com ，这里不要乱填写，这也是最重要的配置
CN='registry.igoodful.com'
# 域名去掉后缀剩下的部分
CN_PREFX='registry.igoodful'
# 配置主机名称，
HOSTNAME=''
if [ "$HOSTNAME" = "" ]; then
	HOSTNAME=$(hostname)
fi
# 生成CA私钥和CA证书
function create_ca() {
	openssl genrsa -out ca.key 4096
	openssl req -x509 -new -nodes -sha512 -days 3650 -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}/emailAddress=${emailAddress}" -key ca.key -out ca.crt
}

# 根据CA证书生成服务器私钥、生成服务器证书签名请求、生成一个x509的v3扩展文件，服务器证书
function create_server_ca() {
	#
	openssl genrsa -out ${CN}.key 4096
	#
	openssl req -sha512 -new -subj "/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}/emailAddress=${emailAddress}" -key ${CN}.key -out ${CN}.csr
	#
	cat >v3.ext <<-EOF
		authorityKeyIdentifier=keyid,issuer
		basicConstraints=CA:FALSE
		keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
		extendedKeyUsage = serverAuth
		subjectAltName = @alt_names

		[alt_names]
		DNS.1=${CN}
		DNS.2=${CN_PREFX}
		DNS.3=${HOSTNAME}
	EOF
	#
	openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CA ca.crt -CAkey ca.key -CAcreateserial -in ${CN}.csr -out ${CN}.crt
	#
	openssl x509 -inform PEM -in ${CN}.crt -out ${CN}.cert
}

function main() {
	create_ca
	create_server_ca
}
main
