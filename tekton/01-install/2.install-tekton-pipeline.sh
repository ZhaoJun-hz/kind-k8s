#!/bin/bash
date
set -v

kubectl apply -f yaml/tekton-pipeline.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
