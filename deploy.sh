#!/bin/bash

# 生成静态网站（包含草稿）
hugo -D

# 添加所有更改到暂存区
git add .

# 获取当前日期（自动生成）
COMMIT_DATE=$(date +"%Y-%m-%d %H:%M")

# 提交到本地仓库
git commit -m "自动部署: $COMMIT_DATE"

# 推送到 GitHub
git push origin main

echo "✅ 部署完成！"