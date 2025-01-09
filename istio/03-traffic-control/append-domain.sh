#!/bin/bash
date
set -v

# 获取 istio-ingressgateway 的 EXTERNAL_IP
EXTERNAL_IP=$(kubectl get service istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# 检查 EXTERNAL_IP 是否获取成功
if [[ -z "$EXTERNAL_IP" ]]; then
  echo "ERROR: Unable to fetch EXTERNAL_IP for istio-ingressgateway!"
  exit 1
fi

# 定义映射的域名
DOMAIN="nginx.web.com"
# 输出信息
echo "Mapping $DOMAIN to $EXTERNAL_IP in /etc/hosts..."

# 检查 /etc/hosts 文件中是否已存在该域名的条目
if grep -q "$DOMAIN" /etc/hosts; then
  # 如果存在相关条目，则删除旧的映射
  echo "Found existing mapping for $DOMAIN. Removing it..."
  sudo sed -i.bak "/$DOMAIN/d" /etc/hosts
fi

# 追加新的映射到 /etc/hosts
echo "$EXTERNAL_IP $DOMAIN" | sudo tee -a /etc/hosts > /dev/null

# 验证更新是否成功
if grep -q "$DOMAIN" /etc/hosts; then
  echo "Successfully mapped $DOMAIN to $EXTERNAL_IP in /etc/hosts."
else
  echo "ERROR: Failed to update /etc/hosts!"
  exit 1
fi