#!/bin/bash
date
set -v

kubectl apply -f istio-addones-gateway.yaml

EXTERNAL_IP=$(kubectl get service istio-ingressgateway -n istio-system -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

./update-hosts.sh my.kiali.com $EXTERNAL_IP
./update-hosts.sh my.grafana.com $EXTERNAL_IP
./update-hosts.sh my.prometheus.com $EXTERNAL_IP
./update-hosts.sh my.tracing.com $EXTERNAL_IP