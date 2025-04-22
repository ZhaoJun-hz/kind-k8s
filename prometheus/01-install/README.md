## 镜像准备
```shell
docker pull jimmidyson/configmap-reload:v0.9.0
docker tag jimmidyson/configmap-reload:v0.9.0 my.harbor.cn/k8sstudy/configmap-reload:v0.9.0
docker push my.harbor.cn/k8sstudy/configmap-reload:v0.9.0

docker pull prom/prometheus:v3.1.0
docker tag prom/prometheus:v3.1.0 my.harbor.cn/k8sstudy/prometheus:v3.1.0
docker push my.harbor.cn/k8sstudy/prometheus:v3.1.0

docker pull registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.14.0
docker tag registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.14.0  my.harbor.cn/k8sstudy/kube-state-metrics:v2.14.0
docker push my.harbor.cn/k8sstudy/kube-state-metrics:v2.14.0

docker pull busybox:1.37.0
docker tag busybox:1.37.0 my.harbor.cn/k8sstudy/busybox:1.37.0
docker push my.harbor.cn/k8sstudy/busybox:1.37.0

docker pull grafana/grafana:11.4.0
docker tag grafana/grafana:11.4.0 my.harbor.cn/k8sstudy/grafana:11.4.0
docker push my.harbor.cn/k8sstudy/grafana:11.4.0
```

## 脚本解释
1.kind-k8s-setup.sh 使用kind 安装 k8s 集群
2-prepare-install.sh  安装 prometheus 前准备工作
3-install.sh 安装 prometheus ，并配置 prometheus.com 到 prometheus-test-worker 的映射
4-grafana-install.sh 安装 grafana

## 访问prometheus web 界面
prometheus.com:8091 可以访问 prometheus web 界面 
## 访问 grafana web 界面
节点ip:30000 可以访问 grafana web 界面 初始账号/密码 admin/admin，初次访问需要修改密码
添加 prometheus 数据源

添加大盘  
13105
8588  
8685  
