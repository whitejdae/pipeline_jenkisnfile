#!/bin/bash

jobName=$(echo $2 | sed 's/^pica-cloud-//; s/-server$//')
# 查看是否存在
kubectl get pod -o wide -n $1 | grep $2

# 如果不存在则创建
if [ $? -ne 0 ]; then
# 创建pod和service
    # 根据模版cp一份
    cp /root/k8s-pro/pica-cloud-kf-server.yaml /root/k8s-pro/$2.yaml
    # 更改image
    sed -i "s@xxx@xxx@g" /root/k8s-pro/$2.yaml
    # 更改path路径
    sed -i "s/kf/$2/g" /root/k8s-pro/$2.yaml
    # 更改端口
    sed -i "s@xxx@xxx@g" /root/k8s-pro/$2.yaml

    kubectl apply -f /root/k8s-pro/$2.yaml
    echo "Pod and Service create Successfully!!!"

# 创建ingress
    # 根据模版cp一份
    cp /root/k8s-pro/ingress/pica-cloud-kf-server.yaml /root/k8s-pro/ingress/$2.yaml
    # 更改path
    sed -i "s/pica-cloud-kf-server/$2/g" /root/k8s-pro/ingress/$2.yaml

    kubectl apply -f /root/k8s-pro/ingress/$2.yaml
    echo "Ingress create Successfully!!!"
fi
