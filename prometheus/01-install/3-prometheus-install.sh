#!/bin/bash
date
set -v

kubectl apply -f prometheus-config-file/

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A

work_node_ip=`kubectl get node -o wide --no-headers | grep -w "prometheus-test-worker" | awk -F " " '{print $6}'`
./update-hosts.sh prometheus.com $work_node_ip