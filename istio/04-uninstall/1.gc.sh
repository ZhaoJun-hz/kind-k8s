#!/bin/bash
date
set -v

kind delete cluster --name istio-test
docker stop cloud-provider-kind