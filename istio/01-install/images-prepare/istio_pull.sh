#!/bin/bash
date
set -v

image_list=$(for i in $(grep -nir "image:" istio-demo.yaml  | awk '{print $NF}');do echo $i | sed 's/"//g'; done)
for i in $image_list
do
  if [ ${#i} -lt 15 ]; then
    continue
  fi
  docker pull $i
done