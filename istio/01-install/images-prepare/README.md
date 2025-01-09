## 文件由来
istio版本 1.24.2  
istio-demo.yaml 由如下命令生成
```shell
istioctl manifest generate --set profile=demo >> istio-demo.yaml
```
bookinfo.yaml 由istio 包下文件
/root/istio-1.24.2/samples/bookinfo/platform/kube
addone 文件夹 由istio 包下文件夹
/root/istio-1.24.2/samples/addons

另外，kind 本身 不提供 为 Loadbalancer 类型的 service 分配ip，使用借用 cloud-controller-manager来实现，cloud-controller-manager 0.4.0 版本需要依赖envoy:v1.30.1，需提前准备

## 在一台可以拉取docker镜像的机器执行
主要是解决一些镜像下载慢或者无法下载的问题，并上传到私有harbor 镜像仓库
分别执行如下脚本
```shell
./istio_pull.sh
./istio_push.sh
./bookinfo_pull
./bookinfo_push.sh
./addones_pull.sh
./addones_push.sh

docker pull registry.k8s.io/cloud-provider-kind/cloud-controller-manager:v0.4.0
docker tag 1785147d1062 my.harbor.cn/k8sstudy/cloud-provider-kind/cloud-controller-manager:v0.4.0
docker push  my.harbor.cn/k8sstudy/cloud-provider-kind/cloud-controller-manager:v0.4.0
```
