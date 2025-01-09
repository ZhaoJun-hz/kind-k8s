#!/bin/bash
date
set -v

kubectl label namespace default istio-injection=enabled
istioctl analyze

istioctl experimental precheck

cd ~
rm -rf istio-1.24.2
tar -zxvf istio-1.24.2-linux-arm64.tar.gz

cd /root/istio-1.24.2/samples/bookinfo/platform/kube
cp bookinfo.yaml bookinfo.yaml.bak
sed -i 's#docker.io/istio#my.harbor.cn/k8sstudy/istio#g' bookinfo.yaml
kubectl apply -f bookinfo.yaml
kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

cd /root/istio-1.24.2/samples/bookinfo/networking
kubectl apply -f bookinfo-gateway.yaml
kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system
export INGRESS_HOST=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n "$INGRESS_NS" get service "$INGRESS_NAME" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"

