#!/bin/bash
date
set -v

kubectl label $(kubectl get nodes -o name | grep control-plane) node.kubernetes.io/exclude-from-external-load-balancers-

docker run --rm --network kind -d -v /var/run/docker.sock:/var/run/docker.sock --name cloud-provider-kind my.harbor.cn/k8sstudy/cloud-provider-kind/cloud-controller-manager:v0.4.0

docker pull my.harbor.cn/k8sstudy/envoyproxy/envoy:v1.30.1
docker tag my.harbor.cn/k8sstudy/envoyproxy/envoy:v1.30.1 docker.io/envoyproxy/envoy:v1.30.1

kubectl apply -f loadbalancer.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A

# 等待 EXTERNAL-IP 被分配
echo "等待 EXTERNAL-IP 分配中..."
while true; do
  # 获取 EXTERNAL-IP
  EXTERNAL_IP=$(kubectl get service lb-service-local -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

  # 检查 EXTERNAL-IP 是否分配
  if [[ -n "$EXTERNAL_IP" ]]; then
    echo "EXTERNAL-IP 已分配: $EXTERNAL_IP"
    break
  fi

  # 等待 5 秒后重试
  sleep 5
done

# 将 EXTERNAL-IP 赋值到变量中，并发起请求
URL="$EXTERNAL_IP/hostname"
echo "请求 URL: $URL"
RESPONSE=$(curl -s $URL)

# 打印请求结果
echo "请求结果: $RESPONSE"