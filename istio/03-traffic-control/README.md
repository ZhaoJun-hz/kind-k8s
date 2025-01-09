## 测试
进入到client 容器中
```shell
kubectl exec -it client-c8f5f6bcd-9gqn2 -n traffic-control -- bash
# client 执行
while true
  do
    curl nginx-web:8080
    sleep 0.3
  done 
```

```shell
kubectl apply -f 01-traffic-v1.yaml
# client 执行
while true
  do
    curl nginx-webv1:8080
    sleep 0.3
  done 
  
kubectl delete -f 01-traffic-v1.yaml
```


```shell
kubectl apply -f 02-traffic-v2.yaml
# client 执行
while true
  do
    curl nginx-webv2:8080
    sleep 0.3
  done 
  
kubectl delete -f 02-traffic-v2.yaml
```

```shell
kubectl apply -f 03.traffic-webv1-25-webv2-25-web-50.yaml
# client 执行
while true
  do
    curl nginx-web-all:8080
    sleep 0.3
  done 
  
kubectl delete -f 03.traffic-webv1-25-webv2-25-web-50.yaml
```

```shell
kubectl apply -f 04-traffic-url.yaml
# client 执行
while true
  do
    for i in 0 1 2
      do
        if [ "$i" -eq 0 ]; then
          curl nginx-web-all:8080
        else
          curl nginx-web-all:8080/webv${i}
        fi
        sleep 0.3
      done
  done 
  
kubectl delete -f 04-traffic-url.yaml
```


```shell
kubectl apply -f 05-traffic-url-webv1-25-webv2-25-web-50.yaml
# client 执行
while true
  do
    curl nginx-web-all:8080/web
    sleep 0.3
  done 
  
kubectl delete -f 05-traffic-url-webv1-25-webv2-25-web-50.yaml
```


```shell
kubectl apply -f 06-traffic-header.yaml
# client 执行
while true
  do
    for i in 1 2 3 4
      do
      curl -H "version: v${i}" nginx-web-all:8080
        sleep 0.3
      done
  done 
  
kubectl delete -f 06-traffic-header.yaml
```

```shell
kubectl apply -f 07-traffic-rule-subset.yaml
# client 执行
while true
  do
    for i in 1 2 3 4
      do
      curl -H "version: v${i}" nginx-web-all:8080
        sleep 0.3
      done
  done 
  
kubectl delete -f 07-traffic-rule-subset.yaml
```

```shell
kubectl apply -f 08-traffic-rule-subset-policy.yaml
# client 执行
while true
  do
    curl nginx-web-all:8080
    sleep 0.3
  done 
  
kubectl delete -f 08-traffic-rule-subset-policy.yaml
```


```shell
kubectl apply -f 09-traffic-gateway-virtualservice.yaml

# 宿主机执行
先添加域名映射，执行如下命令
./append-domain.sh

while true
  do
    curl nginx.web.com
    sleep 0.3
  done

kubectl delete -f 09-traffic-gateway-virtualservice.yaml
```

```shell
kubectl apply -f 10-traffic-gateway-destinationrule.yaml

# 宿主机执行
先添加域名映射，执行如下命令
./append-domain.sh
 

while true
  do
    for i in 1 2 3 4
      do
        curl -H "version: v${i}" nginx.web.com
        sleep 0.3
    done
  done

kubectl delete -f 10-traffic-gateway-destinationrule.yaml
```