```shell
03-trigger.yaml 需要用到 02-pipeline-pipelineRun.yaml  
kubectl port-forward service/el-hello-listener 8080
curl -v    -H 'content-Type: application/json'    -d '{"username": "Tekton"}'    http://localhost:8080
```