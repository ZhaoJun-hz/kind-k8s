#!/bin/bash
date
set -v
# 创建监控etcd 需要的 secret
kubectl create secret generic etcd-certs --from-file=/root/data/control-plane-config/pki/etcd/healthcheck-client.crt --from-file=/root/data/control-plane-config/pki/etcd/healthcheck-client.key --from-file=/root/data/control-plane-config/pki/etcd/ca.crt -n kube-system
# 安装state-metrics
kubectl apply -f kube-state-metrics/

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
