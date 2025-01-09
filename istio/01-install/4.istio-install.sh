#!/bin/bash
date
set -v

cd ~
tar -zxvf istio-1.24.2-linux-arm64.tar.gz
cp istio-1.24.2/bin/istioctl /usr/local/bin/
chmod +x /usr/local/bin/istioctl

istioctl install --set profile=demo --set hub=my.harbor.cn/k8sstudy/istio --set tag=1.24.2 -y

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A