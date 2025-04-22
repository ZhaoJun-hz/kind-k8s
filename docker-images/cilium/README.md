```shell
docker pull quay.io/cilium/operator-generic:v1.17.3
docker tag quay.io/cilium/operator-generic:v1.17.3 my.harbor.cn/k8sstudy/cilium/operator-generic:v1.17.3
docker push my.harbor.cn/k8sstudy/cilium/operator-generic:v1.17.3

docker pull quay.io/cilium/cilium:v1.17.3
docker tag quay.io/cilium/cilium:v1.17.3 my.harbor.cn/k8sstudy/cilium/cilium:v1.17.3
docker push my.harbor.cn/k8sstudy/cilium/cilium:v1.17.3


docker pull quay.io/cilium/cilium-envoy:v1.32.5-1744305768-f9ddca7dcd91f7ca25a505560e655c47d3dec2cf
docker tag quay.io/cilium/cilium-envoy:v1.32.5-1744305768-f9ddca7dcd91f7ca25a505560e655c47d3dec2cf my.harbor.cn/k8sstudy/cilium/cilium-envoy:v1.32.5-1744305768-f9ddca7dcd91f7ca25a505560e655c47d3dec2cf
docker push my.harbor.cn/k8sstudy/cilium/cilium-envoy:v1.32.5-1744305768-f9ddca7dcd91f7ca25a505560e655c47d3dec2cf
```