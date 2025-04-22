#!/bin/bash
set -v
# 1. Prepare NoCNI kubernetes environment
cat <<EOF | kind create cluster --name=cilium-kubeproxy-replacement-vxlan --image=my.harbor.cn/k8sstudy/kindest/node:v1.31.4 -v=9 --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true
  kubeProxyMode: "none" # Disable Kubernetes KubeProxy
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

# 2. Remove kubernetes node taints
controller_node_ip=`kubectl get node -o wide --no-headers | grep -E "control-plane" | awk -F " " '{print $6}'`
kubectl taint nodes $(kubectl get nodes -o name | grep control-plane) node-role.kubernetes.io/control-plane:NoSchedule-
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

# 3. Install CNI[Cilium 1.15.0-rc.1]
cilium_version=v1.17.3
cilium_envoy_version=v1.32.5-1744305768-f9ddca7dcd91f7ca25a505560e655c47d3dec2cf
docker pull my.harbor.cn/k8sstudy/cilium/cilium:$cilium_version && docker pull my.harbor.cn/k8sstudy/cilium/operator-generic:$cilium_version && docker pull my.harbor.cn/k8sstudy/cilium/cilium-envoy:$cilium_envoy_version
docker tag my.harbor.cn/k8sstudy/cilium/cilium:$cilium_version quay.io/cilium/cilium:$cilium_version && docker tag my.harbor.cn/k8sstudy/cilium/operator-generic:$cilium_version quay.io/cilium/operator-generic:$cilium_version && docker tag my.harbor.cn/k8sstudy/cilium/cilium-envoy:$cilium_envoy_version quay.io/cilium/cilium-envoy:$cilium_envoy_version
kind load docker-image quay.io/cilium/cilium:$cilium_version quay.io/cilium/operator-generic:$cilium_version quay.io/cilium/cilium-envoy:$cilium_envoy_version --name cilium-kubeproxy-replacement-vxlan
{ helm repo add cilium https://helm.cilium.io ; helm repo update; } > /dev/null 2>&1

# Direct Routing Options(--set routingMode=native --set autoDirectNodeRoutes=true --set ipv4NativeRoutingCIDR="10.0.0.0/8")
helm install cilium cilium/cilium --set k8sServiceHost=$controller_node_ip --set k8sServicePort=6443 --version 1.17.3 --namespace kube-system --set image.pullPolicy=IfNotPresent --set debug.enabled=true --set debug.verbose="datapath flow kvstore envoy policy" --set bpf.monitorAggregation=none --set monitor.enabled=true --set ipam.mode=cluster-pool --set cluster.name=cilium-kubeproxy-replace-vxlan --set kubeProxyReplacement=true --set routingMode=tunnel --set tunnelProtocol=vxlan --set ipv4NativeRoutingCIDR="10.0.0.0/8"

# 4. Wait all pods ready
kubectl wait --timeout=100s --for=condition=Ready=true pods --all -A

# 5. Cilium status(cilium status --verbose)
kubectl -nkube-system exec -it ds/cilium -- cilium status

# 6. Separate namesapce and cgroup v2 verify [https://github.com/cilium/cilium/pull/16259 && https://docs.cilium.io/en/stable/installation/kind/#install-cilium]
for container in $(docker ps -a --format "table {{.Names}}" | grep cilium-kubeproxy);do docker exec $container ls -al /proc/self/ns/cgroup;done
mount -l | grep cgroup && docker info | grep "Cgroup Version" | awk '$1=$1'

