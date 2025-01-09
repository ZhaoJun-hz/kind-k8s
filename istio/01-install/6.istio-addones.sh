#!/bin/bash
date
set -v

cd /root/istio-1.24.2/
cp -a samples/addons{,-bak}
grep -nir "image:" samples/addons/* > tmp.txt
sed -i 's/"//g' tmp.txt
cat tmp.txt | while read line
do
	file_name=$(echo $line|awk -F':' '{print $1}')
  repo_name=$(echo $line | awk -F': ' '{print $NF}' | awk -F'/' 'OFS="/" {$NF=null; print $0}')
  sed -i "/image: /s#$repo_name#my.harbor.cn/k8sstudy/istio/#" $file_name
done
kubectl apply -f samples/addons/

kubectl wait --timeout=300s --for=condition=Ready=true pods --all -A