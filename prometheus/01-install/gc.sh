#!/bin/bash
date
set -v

kind delete cluster --name prometheus-test
rm -rf /root/data/control-plane-config/*
rm -rf /root/data/worker/prometheus/*
rm -rf /root/data/worker/grafana/*