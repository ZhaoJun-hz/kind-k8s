#!/bin/bash
date
set -v

image_list=$(for i in $(grep -nir "image:" bookinfo.yaml  | awk '{print $NF}');do echo $i | sed 's/"//g'; done)
for i in $image_list
do
  docker pull $i
done