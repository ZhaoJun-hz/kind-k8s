#!/bin/bash
date
set -v
mv /root/docker-compose /usr/local/bin/
mv /root/crictl /usr/local/bin/

mkdir /root/harbor/data/ssl -p
cd /root/harbor/data/ssl
openssl genrsa -out ca.key 3072
openssl req  -subj "/C=CN/ST=HeNan/L=ZhengZhou/O=ShuDong/OU=Develop/CN=my.harbor.cn" -new -x509 -days 3650 -key ca.key -out ca.pem
openssl genrsa -out harbor.key 3072
openssl req -subj "/C=CN/ST=HeNan/L=ZhengZhou/O=ShuDong/OU=Develop/CN=my.harbor.cn" -new -key harbor.key -out harbor.csr
openssl x509 -req -in harbor.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out harbor.pem -days 3650

mkdir /root/harbor/install -p
mv /root/harbor-offline-installer-aarch64-v2.10.2.tgz /root/harbor/install/
cd  /root/harbor/install
tar -zxvf harbor-offline-installer-aarch64-v2.10.2.tgz
cd harbor
cp harbor.yml.tmpl harbor.yml
# 定义文件路径
FILE="harbor.yml"
# 使用 sed 命令进行替换
sed -i 's/hostname: reg.mydomain.com/hostname: my.harbor.cn/' "$FILE"
sed -i 's|certificate: /your/certificate/path|certificate: /root/harbor/data/ssl/harbor.pem|' "$FILE"
sed -i 's|private_key: /your/private/key/path|private_key: /root/harbor/data/ssl/harbor.key|' "$FILE"
echo "替换完成！"
./install.sh


