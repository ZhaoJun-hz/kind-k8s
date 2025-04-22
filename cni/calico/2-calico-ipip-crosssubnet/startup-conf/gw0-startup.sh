#!/bin/bash

# 配置网络接口
ip addr add 10.10.10.1/24 dev eth1
ip addr add 10.10.66.1/24 dev eth2
ip link set eth1 up
ip link set eth2 up
ip link set lo up

# 启用 NAT
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -s 10.10.0.0/16 -j MASQUERADE