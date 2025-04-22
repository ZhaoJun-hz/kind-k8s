#!/bin/bash
kubectl apply -f cni.yaml
kubectl run cni-demo --image=my.harbor.cn/k8sstudy/nettool:latest