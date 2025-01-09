## 添加脚本可执行权限
```shell
chmod +x *.sh
```

## 准备istio 安装需要的镜像文件
详见images-prepare 文件夹下 README.md

## 准备安装
使用root 用户  
下载 istio-1.24.2-linux-arm64.tar.gz 放置到家目录
```shell
cd ~
tar -zxvf istio-1.24.2-linux-arm64.tar.gz
cp istio-1.24.2/bin/istioctl /usr/local/bin/
chmod +x /usr/local/bin/istioctl
```
## 脚本解释
1.kind-k8s-setup.sh  使用 kind 初始化 k8s集群
2.kind-loadbalancer.sh 使用 cloud-controller-manager 提供 kind 为为 Loadbalancer 类型的 service 分配ip的能力，为后续istio gateway 访问做准备
4.istio-install.sh 安装 istio
5.istio-bookinfo.sh 部署bookinfo 示例应用
6.istio-addones.sh 部署 istio addons 
## 安装
```shell
./1.kind-k8s-setup.sh
./2.kind-loadbalancer.sh
./4.istio-install.sh
./5.istio-bookinfo.sh
./6.istio-addones.sh
```