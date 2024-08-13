#bin/bash

for i in $(seq 1 100)
  do
    unavailable_num=$(kubectl describe deploy $2 -n $1 | grep "Replicas" | awk -F '|' '{print $5}' | awk -F ' ' '{print $1}')
    if [ "$unavailable_num" -ne 0 ]
       then
       sleep 5
       echo "Service Updating"
           if [ $i -eq 50 ]
              then
              echo "请登陆腾讯查看问题!!!!"
              # shellcheck disable=SC2242
              exit -1
           fi
    else
        echo "Service Updated Successfully"
        break
    fi
done