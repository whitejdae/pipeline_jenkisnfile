#!/bin/bash
date=$(date "+%Y%m%d-%H%M%S")
rollback_path="/data/nginx_rollback/$1"

# 判断是否存在
if [ -d "$rollback_path" ]; then
  echo "The directory already exists"
else
  mkdir -pv "$rollback_path"
fi

# 判断是否为多级目录
if [[ "$1" == */* ]]; then
  backup_path=$(dirname "$1")
  backup_name=$(basename "$1")
  cd "/usr/share/nginx/html/$backup_path" && tar -czvf "$rollback_path/$date.gz" "$backup_name"
else
  # 切换到目录备份
  cd "/usr/share/nginx/html" && tar -czvf "$rollback_path/$date.gz" "$1"
fi

# 切换到目录
cd "$rollback_path" || exit

# 列出目录下的文件，并按创建时间逆序排序
sorted_files=$(ls -rt | head -n -2)

# 删除除最新的两个文件以外的其他文件
echo "$sorted_files" | while read -r file; do
  rm -f "$file"
  echo "Deleted: $file"
done

# 列出文件
ls -l