#!/bin/bash
date
set -v

kubectl apply -f grafana-install.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A