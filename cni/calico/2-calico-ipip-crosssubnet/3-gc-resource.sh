#!/bin/bash

set -v
kubectl delete -f ./cni.yaml

ifconfig br-pool0 down
brctl delbr br-pool0

ifconfig br-pool1 down
brctl delbr br-pool1

clab destroy --all
kind delete clusters -A
