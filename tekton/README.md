```shell
docker pull ghcr.io/tektoncd/pipeline/resolvers-ff86b24f130c42b88983d3c13993056d:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/resolvers-ff86b24f130c42b88983d3c13993056d:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/resolvers-ff86b24f130c42b88983d3c13993056d:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/resolvers-ff86b24f130c42b88983d3c13993056d:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/entrypoint-bff0a22da108bc2f16c818c97641a296:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/entrypoint-bff0a22da108bc2f16c818c97641a296:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/entrypoint-bff0a22da108bc2f16c818c97641a296:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/entrypoint-bff0a22da108bc2f16c818c97641a296:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/nop-8eac7c133edad5df719dc37b36b62482:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/nop-8eac7c133edad5df719dc37b36b62482:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/nop-8eac7c133edad5df719dc37b36b62482:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/nop-8eac7c133edad5df719dc37b36b62482:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/sidecarlogresults-7501c6a20d741631510a448b48ab098f:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/sidecarlogresults-7501c6a20d741631510a448b48ab098f:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/sidecarlogresults-7501c6a20d741631510a448b48ab098f:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/sidecarlogresults-7501c6a20d741631510a448b48ab098f:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/workingdirinit-0c558922ec6a1b739e550e349f2d5fc1:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/workingdirinit-0c558922ec6a1b739e550e349f2d5fc1:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/workingdirinit-0c558922ec6a1b739e550e349f2d5fc1:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/workingdirinit-0c558922ec6a1b739e550e349f2d5fc1:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/controller-10a3e32792f33651396d02b6855a6e36:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/controller-10a3e32792f33651396d02b6855a6e36:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/controller-10a3e32792f33651396d02b6855a6e36:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/controller-10a3e32792f33651396d02b6855a6e36:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/webhook-d4749e605405422fd87700164e31b2d1:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/webhook-d4749e605405422fd87700164e31b2d1:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/webhook-d4749e605405422fd87700164e31b2d1:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/webhook-d4749e605405422fd87700164e31b2d1:v0.66.0

docker pull ghcr.io/tektoncd/pipeline/events-a9042f7efb0cbade2a868a1ee5ddd52c:v0.66.0
docker tag ghcr.io/tektoncd/pipeline/events-a9042f7efb0cbade2a868a1ee5ddd52c:v0.66.0 my.harbor.cn/k8sstudy/tektoncd/pipeline/events-a9042f7efb0cbade2a868a1ee5ddd52c:v0.66.0
docker push my.harbor.cn/k8sstudy/tektoncd/pipeline/events-a9042f7efb0cbade2a868a1ee5ddd52c:v0.66.0

docker pull ghcr.io/tektoncd/triggers/controller-f656ca31de179ab913fa76abc255c315:v0.30.1
docker tag ghcr.io/tektoncd/triggers/controller-f656ca31de179ab913fa76abc255c315:v0.30.1 my.harbor.cn/k8sstudy/tektoncd/triggers/controller-f656ca31de179ab913fa76abc255c315:v0.30.1
docker push my.harbor.cn/k8sstudy/tektoncd/triggers/controller-f656ca31de179ab913fa76abc255c315:v0.30.1

docker pull ghcr.io/tektoncd/triggers/webhook-dd1edc925ee1772a9f76e2c1bc291ef6:v0.30.1
docker tag ghcr.io/tektoncd/triggers/webhook-dd1edc925ee1772a9f76e2c1bc291ef6:v0.30.1 my.harbor.cn/k8sstudy/tektoncd/triggers/webhook-dd1edc925ee1772a9f76e2c1bc291ef6:v0.30.1
docker push my.harbor.cn/k8sstudy/tektoncd/triggers/webhook-dd1edc925ee1772a9f76e2c1bc291ef6:v0.30.1

docker pull ghcr.io/tektoncd/triggers/interceptors-3176d6a3f314c3655b30bfd36e421dd5:v0.30.1
docker tag ghcr.io/tektoncd/triggers/interceptors-3176d6a3f314c3655b30bfd36e421dd5:v0.30.1 my.harbor.cn/k8sstudy/tektoncd/triggers/interceptors-3176d6a3f314c3655b30bfd36e421dd5:v0.30.1
docker push my.harbor.cn/k8sstudy/tektoncd/triggers/interceptors-3176d6a3f314c3655b30bfd36e421dd5:v0.30.1

docker pull gcr.io/tekton-releases/github.com/tektoncd/results/cmd/api:v0.13.2
docker tag gcr.io/tekton-releases/github.com/tektoncd/results/cmd/api:v0.13.2 my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/api:v0.13.2
docker push my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/api:v0.13.2

docker pull gcr.io/tekton-releases/github.com/tektoncd/results/cmd/retention-policy-agent:v0.13.2
docker tag gcr.io/tekton-releases/github.com/tektoncd/results/cmd/retention-policy-agent:v0.13.2 my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/retention-policy-agent:v0.13.2
docker push my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/retention-policy-agent:v0.13.2

docker pull gcr.io/tekton-releases/github.com/tektoncd/results/cmd/watcher:v0.13.2
docker tag gcr.io/tekton-releases/github.com/tektoncd/results/cmd/watcher:v0.13.2 my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/watcher:v0.13.2
docker push my.harbor.cn/k8sstudy/tekton-releases/github.com/tektoncd/results/cmd/watcher:v0.13.2

docker pull cgr.dev/chainguard/busybox@sha256:19f02276bf8dbdd62f069b922f10c65262cc34b710eea26ff928129a736be791
docker tag cgr.dev/chainguard/busybox@sha256:19f02276bf8dbdd62f069b922f10c65262cc34b710eea26ff928129a736be791 my.harbor.cn/k8sstudy/chainguard/busybox:v0.0.1
docker push my.harbor.cn/k8sstudy/chainguard/busybox:v0.0.1

docker pull ghcr.io/tektoncd/triggers/eventlistenersink-7ad1faa98cddbcb0c24990303b220bb8:v0.30.1
docker tag ghcr.io/tektoncd/triggers/eventlistenersink-7ad1faa98cddbcb0c24990303b220bb8:v0.30.1 my.harbor.cn/k8sstudy/tektoncd/triggers/eventlistenersink-7ad1faa98cddbcb0c24990303b220bb8:v0.30.1
docker push my.harbor.cn/k8sstudy/tektoncd/triggers/eventlistenersink-7ad1faa98cddbcb0c24990303b220bb8:v0.30.1

docker pull bitnami/postgresql:14.15.0
docker tag bitnami/postgresql:14.15.0 my.harbor.cn/k8sstudy/bitnami/postgresql:14.15.0
docker push my.harbor.cn/k8sstudy/bitnami/postgresql:14.15.0


```

```shell

kubectl create secret generic tekton-results-postgres --namespace="tekton-pipelines" --from-literal=POSTGRES_USER=postgres --from-literal=POSTGRES_PASSWORD=$(openssl rand -base64 20)

openssl req -x509 \
-newkey rsa:4096 \
-keyout key.pem \
-out cert.pem \
-days 365 \
-nodes \
-subj "/CN=tekton-results-api-service.tekton-pipelines.svc.cluster.local" \
-addext "subjectAltName = DNS:tekton-results-api-service.tekton-pipelines.svc.cluster.local"

kubectl create secret tls -n tekton-pipelines tekton-results-tls \
--cert=cert.pem \
--key=key.pem


```