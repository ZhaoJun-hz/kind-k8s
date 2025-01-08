#!/bin/bash

# 定义旧的和新的镜像仓库地址
OLD_REGISTRY="harbor.cn"
NEW_REGISTRY="my.harbor.cn"

# 获取所有旧镜像的列表
images=$(docker images | grep "$OLD_REGISTRY" | awk '{print $1 ":" $2}')

# 遍历每个镜像，重新打标签并推送到新的镜像仓库
for image in $images; do
  # 提取新的镜像地址
  new_image=$(echo $image | sed "s#$OLD_REGISTRY#$NEW_REGISTRY#")

  echo "Processing image: $image"
  echo "Retagging image as: $new_image"

  # 打标签
  docker tag "$image" "$new_image"

  echo "Pushing image: $new_image"

  # 推送到新的仓库
  docker push "$new_image"

  echo "Image $image successfully retagged and pushed to $new_image"
done

echo "All images have been processed."