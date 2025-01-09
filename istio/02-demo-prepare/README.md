## 本地镜像准备
docker build -f DockerfileWeb -t nginx:web .
docker tag nginx:web my.harbor.cn/k8sstudy/nginx:web
docker push my.harbor.cn/k8sstudy/nginx:web
docker build -f DockerfileWebV1 -t nginx:webv1 .
docker tag nginx:webv1 my.harbor.cn/k8sstudy/nginx:webv1
docker push my.harbor.cn/k8sstudy/nginx:webv1
docker build -f DockerfileWebV2 -t nginx:webv2 .
docker tag nginx:webv2 my.harbor.cn/k8sstudy/nginx:webv2
docker push my.harbor.cn/k8sstudy/nginx:webv2

## 添加脚本可执行权限
```shell
chmod +x *.sh
```
## 准备环境
创建namespace 和 相关 Deployment 和 Service
```shell
./01.setup.sh
```

## 不开启 istio 自动注入测试
```shell
# client-c8f5f6bcd-f5tc7 改成自己环境的
kubectl exec -it client-c8f5f6bcd-f5tc7 -n traffic-control -- bash

nslookup nginx-web-all
nslookup nginx-web
nslookup nginx-webv1
nslookup nginx-webv2

curl nginx-web-all:8080
curl nginx-web:8080
curl nginx-webv1:8080
curl nginx-webv2:8080

while true
  do
    curl nginx-web-all:8080
    sleep 0.3
  done 
```

## 开启 istio 自动注入测试
```shell
kubectl label namespace traffic-control istio-injection=enabled
```