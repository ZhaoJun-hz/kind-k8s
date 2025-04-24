## 获取 vyos arm 镜像
https://github.com/sever-sever/vyos-build-arm64 该网站提供一个已经打包好的iso版本
https://dev.to/sofianehamlaoui/convert-iso-images-to-docker-images-18jh  将 iso 转成docker image

## vyos arm 每周更新的版本

https://github.com/huihuimoe/vyos-arm64-build/releases

## 将 ISO 转为 docker image，在远程服务器上执行
将 ISO 上传到 vyos-docker 目录
```shell
cd vyos-docker/
mkdir rootfs unquashfs
sudo mount -o loop vyos-1.5-rolling-202504180226-generic-arm64.iso rootfs
find . -type f | grep filesystem.squashfs
sudo unsquashfs -f -d unsquashfs/ ./rootfs/live/filesystem.squashfs
sudo tar -C unsquashfs -c . | docker import - my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202504180226
docker push my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202504180226
```
## 安装依赖
在此基础上，安装一些依赖
```shell
docker build -t my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202504180226-dependency .
docker push my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202504180226-dependency


```

