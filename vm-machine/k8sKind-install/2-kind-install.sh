#!/bin/bash
date
set -v

mkdir -p /etc/docker/
mkdir -p /etc/containerd/

mv /root/daemon.json /etc/docker/daemon.json
systemctl start docker && systemctl enable docker.service
./update-hosts.sh my.harbor.cn 10.66.66.100
docker login my.harbor.cn -u admin -p Harbor12345

mv /root/config.toml /etc/containerd/config.toml
systemctl start containerd && systemctl enable containerd

mv /root/kind-linux-arm64 /usr/local/bin/kind && chmod +x /usr/local/bin/kind
mv /root/kubectl /usr/local/bin/kubectl && chmod +x /usr/local/bin/kubectl

mv /root/crictl /usr/local/bin/crictl && chmod +x /usr/local/bin/crictl
crictl config --set runtime-endpoint=unix:///run/containerd/containerd.sock
systemctl restart containerd.service

docker pull my.harbor.cn/k8sstudy/kindest/node:v1.31.4
crictl pull my.harbor.cn/k8sstudy/nettool