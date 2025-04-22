## 获取 vyos arm 镜像
https://github.com/sever-sever/vyos-build-arm64 该网站提供一个已经打包好的iso版本
https://dev.to/sofianehamlaoui/convert-iso-images-to-docker-images-18jh  将 iso 转成docker image

在此基础上，安装一些依赖
```shell
docker build -t my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202405251335 .
docker push my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202405251335


```