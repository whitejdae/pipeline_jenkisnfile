## Pipeline jenkins file

### ℹ️ 简介

常用pipeline模版 方便统一管理

### 💼 功能合集

- 以模版的方式进行统一管理
- 前后端添加回滚备份功能
- post钉钉通知脚本：[文档指引](https://github.com/whitejdae/ops_tool)
- 自动检测pod构建

### 🪡 分类整理

- 前端部署到nginx
```markdown
## pro-node.jenkinsfile

参数化构建整理：

1. git参数
名称： branch
描述：
分支类型：branch
默认值：release

2. 选项参数：
名称1：envProfile
选项：dev
     test
     uat
     prod
描述：

名称2：status
选项： devops
      rollback
描述：

名称3：nodeVersion
选项： nodejs-12.22.0
      nodejs-14.16.0
描述：

3.字符参数：
名称3：git
默认值：http://xxx
描述：
```

- 后端部署到cloud
```markdown
## pro-cloud.jenkinsfile

参数化构建整理：

1. git参数 
名称： branch
描述：
分支类型：branch
默认值：release

2. 选项参数：
名称：status
选项： devops
      rollback
描述：
   
3.字符参数：
名称：git
默认值：http://xxx
描述：
```