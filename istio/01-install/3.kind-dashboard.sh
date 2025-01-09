#!/bin/bash
date
set -v

kubectl apply -f dashboard.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A

kubectl get pod -n kubernetes-dashboard

kubectl create serviceaccount -n kubernetes-dashboard admin-user
kubectl create clusterrolebinding -n kubernetes-dashboard admin-user --clusterrole cluster-admin --serviceaccount=kubernetes-dashboard:admin-user
token=$(kubectl -n kubernetes-dashboard create token admin-user)
echo $token
kubectl proxy