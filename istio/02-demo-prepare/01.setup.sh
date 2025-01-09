#!/bin/bash
date
set -v

kubectl apply -f 02.namespace.yaml
kubectl label namespace traffic-control istio-injection=enabled
kubectl apply -f 03.demo-prepare.yaml
kubectl wait --timeout=300s --for=condition=Ready=true pods --all -n traffic-control