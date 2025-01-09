#!/bin/bash
date
set -v

image_list=$(for i in $(grep -nir "image:" bookinfo.yaml  | awk '{print $NF}');do echo $i | sed 's/"//g'; done)

for i in $image_list
do
  image_name=$(echo $i | awk -F '/' '{print $NF}')
  docker tag $i my.harbor.cn/k8sstudy/istio/$image_name
  docker push my.harbor.cn/k8sstudy/istio/$image_name
done