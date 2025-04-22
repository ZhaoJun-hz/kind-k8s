#!/bin/bash
date
set -v

kind delete cluster --name tekton-test
