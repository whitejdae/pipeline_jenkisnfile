#!/bin/bash

# 回滚文件
rollback=$(ls -rt /data/nginx_rollback/"$1" | head -1)
backup_path=$(dirname "$1")
#backup_name=$(basename "$1")

# 删除目标目录下的文件
rm -rf /usr/share/nginx/html/"$1"/*
echo "已删除"

# 解压回滚文件到目标目录
tar -xf /data/nginx_rollback/"$1"/"$rollback" -C /usr/share/nginx/html/$backup_path/

echo "Rollback successful ！！！！"