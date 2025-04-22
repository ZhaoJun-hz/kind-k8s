#!/bin/bash
set -v
# 1.prep noCNI env
cat <<EOF | kind create cluster --name=calico-ipip --image=my.harbor.cn/k8sstudy/kindest/node:v1.31.4 -v=9 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true
nodes:
- role: control-plane
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
# 2.remove taints
kubectl taint nodes $(kubectl get nodes -o name | grep control-plane) node-role.kubernetes.io/control-plane:NoSchedule-
kubectl get nodes -o wide

# 3. install CNI[Calico v3.23.2]
kubectl apply -f calico.yaml

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

# 4. wait all pods ready
kubectl wait --timeout=100s --for=condition=Ready=true pods --all -A

