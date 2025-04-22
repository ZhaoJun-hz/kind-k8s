#!/bin/bash
date
set -v

kubectl apply -f yaml/tekton-trigger.yaml
kubectl apply -f yaml/tekton-trigger-interceptors.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A