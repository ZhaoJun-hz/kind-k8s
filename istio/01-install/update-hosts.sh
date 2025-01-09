#!/bin/bash
date
set -v

# 检查是否提供参数
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <DOMAIN> <EXTERNAL_IP>"
  echo "Example: $0 nginx.web.com 192.168.1.100"
  exit 1
fi

# 获取运行时的参数
DOMAIN=$1
EXTERNAL_IP=$2

# 验证 EXTERNAL_IP 格式是否正确（简单的 IPv4 格式校验）
if ! [[ $EXTERNAL_IP =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  echo "ERROR: Invalid IP address format: $EXTERNAL_IP"
  exit 1
fi

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