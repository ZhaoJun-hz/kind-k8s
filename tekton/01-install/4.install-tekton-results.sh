
#!/bin/bash
date
set -v

rm -rf ssl/*
mkdir ssl

kubectl create secret generic tekton-results-postgres --namespace="tekton-pipelines" --from-literal=POSTGRES_USER=postgres --from-literal=POSTGRES_PASSWORD=$(openssl rand -base64 20)

openssl req -x509 \
-newkey rsa:4096 \
-keyout ssl/key.pem \
-out ssl/cert.pem \
-days 3650 \
-nodes \
-subj "/CN=tekton-results-api-service.tekton-pipelines.svc.cluster.local" \
-addext "subjectAltName = DNS:tekton-results-api-service.tekton-pipelines.svc.cluster.local"

kubectl create secret tls -n tekton-pipelines tekton-results-tls \
--cert=ssl/cert.pem \
--key=ssl/key.pem


kubectl apply -f yaml/tekton-results.yaml

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
