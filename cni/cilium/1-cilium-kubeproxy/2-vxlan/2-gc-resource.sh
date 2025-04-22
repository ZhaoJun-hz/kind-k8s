#!/bin/bash

set -v
kubectl delete -f ./cni.yaml
kind delete clusters -A
