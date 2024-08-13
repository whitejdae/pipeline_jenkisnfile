#!/bin/bash

# 获取镜像名
dockerName=$(echo $1 | awk -F ":" {'print $1'} | awk -F "/" {'print $3'})

# 检查是否存在该容器 0为存在1为不存在
docker ps --format '{{.Image}} {{.Names}}' | grep "$PROJECT/$JARNAME:$TIME"
# 如果存在则删除
if [ $? -ne 0 ]; then
    echo "Container already exists. Removing existing container..."
    docker stop $dockerName && docker rm -f $dockerName
    echo "Removing existing container successfully!!!"
fi

# 登陆腾讯容器镜像服务
docker login xxxr.com --username xxx --password xxxx
docker pull $1
docker run --name $dockerName -p 18080:18080 -d $1
# 检查容器是否启动成功
for i in {1..50}; do
    IfRunning=$(docker inspect $dockerName | grep Running | awk {'print $2'})
    if [ "$IfRunning" = "true," ]; then
        echo "Container $dockerName is running successfully."
        break
    else
        echo "Waiting for container to start..."
        sleep 5
    fi
done

docker rmi -f $1
echo "clean $dockerName images successfully"