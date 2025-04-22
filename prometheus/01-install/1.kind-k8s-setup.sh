#!/bin/bash
date
set -v

mkdir /root/data/control-plane-config -p
mkdir /root/data/worker/prometheus -p
mkdir /root/data/worker/grafana -p

cat <<EOF | kind create cluster --name=prometheus-test --image=my.harbor.cn/k8sstudy/kindest/node:v1.31.4 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
#  disableDefaultCNI: true
#  kubeProxyMode: "none" # Enable KubeProxy
  apiServerAddress: "10.66.66.140"
  apiServerPort: 6443

nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /root/data/control-plane-config/
        containerPath: /etc/kubernetes/
  - role: worker
    extraMounts:
      - hostPath: /root/data/worker/prometheus
        containerPath: /data/prometheus
      - hostPath: /root/data/worker/grafana
        containerPath: /data/grafana
  - role: worker
  - role: worker

containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."my.harbor.cn"]
    endpoint = ["https://my.harbor.cn:443"]
  [plugins."io.containerd.grpc.v1.cri".registry.configs."my.harbor.cn".tls]
      insecure_skip_verify = true
  [plugins."io.containerd.grpc.v1.cri".registry.configs."my.harbor.cn".auth]
      username = "admin"
      password = "Harbor12345"
EOF

kubectl taint nodes $(kubectl get nodes -o name | grep control-plane) node-role.kubernetes.io/control-plane:NoSchedule-

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
kubectl get nodes -o wide
# 修改 kube-scheduler 和 kube-controller-manager 绑定的地址，使其可以被prometheus 监控
docker exec -it prometheus-test-control-plane /bin/sh -c "
    # 修改 kube-scheduler.yaml 文件
    sed -i 's/--bind-address=127.0.0.1/--bind-address=0.0.0.0/' /etc/kubernetes/manifests/kube-scheduler.yaml
"

docker exec -it prometheus-test-control-plane /bin/sh -c "
    # 修改 kube-controller-manager.yaml 文件
    sed -i 's/--bind-address=127.0.0.1/--bind-address=0.0.0.0/' /etc/kubernetes/manifests/kube-controller-manager.yaml
"
kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A
kubectl get nodes -o wide

# Define the host entry to be added
HOST_ENTRY="10.66.66.100 my.harbor.cn"
# Get the list of container names from `kubectl get nodes`
CONTAINERS=$(kubectl get nodes -o custom-columns=NAME:.metadata.name --no-headers)
# Loop through each container and add the host entry
for CONTAINER in $CONTAINERS; do
    echo "Updating container: $CONTAINER"
    # Check if the entry already exists in the container's /etc/hosts
    if docker exec "$CONTAINER" grep -q "$HOST_ENTRY" /etc/hosts; then
        echo "Host entry already exists in $CONTAINER. Skipping..."
    else
        # Add the entry to /etc/hosts inside the container
        docker exec "$CONTAINER" sh -c "echo '$HOST_ENTRY' >> /etc/hosts"
        echo "Host entry added to $CONTAINER."
    fi
done
echo "Script execution complete."