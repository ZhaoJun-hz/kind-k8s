#!/bin/bash
set -v

cat <<EOF>clab.yaml | clab deploy -t clab.yaml -
name: vyos-wireguard
topology:
  nodes:
    gwx:
      kind: linux
      image: my.harbor.cn/k8sstudy/nettool
      exec:
        - ip a a 10.1.5.1/24 dev net1
        - ip a a 10.1.8.1/24 dev net2

    wireguard1:
      kind: linux
      image: my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202405251335
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
        - ./startup-conf/vyos-wireguard1.cfg:/opt/vyatta/etc/config/config.boot
        - ./WireGuard:/WireGuard

    wireguard2:
      kind: linux
      image: my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202405251335
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
        - ./startup-conf/vyos-wireguard2.cfg:/opt/vyatta/etc/config/config.boot

    server1:
      kind: linux
      image: my.harbor.cn/k8sstudy/nettool
      exec:
        - ip addr add 10.244.1.10/24 dev net0
        - ip route replace default via 10.244.1.1

    server2:
      kind: linux
      image: my.harbor.cn/k8sstudy/nettool
      exec:
        - ip addr add 10.244.2.10/24 dev net0
        - ip route replace default via 10.244.2.1

  links:
    - endpoints: ["wireguard1:eth1", "server1:net0"]
    - endpoints: ["wireguard2:eth1", "server2:net0"]
    - endpoints: ["wireguard1:eth2", "gwx:net1"]
    - endpoints: ["wireguard2:eth2", "gwx:net2"]


EOF

