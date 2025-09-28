#!/bin/bash
set -e

# 預設 commit 訊息是時間戳
msg="update: $(date)"
if [ $# -eq 1 ]
  then msg="$1"
fi

# 1. build 網站
hugo

# 2. commit + push 內容 repo
git add .
git commit -m "$msg"
git push origin master

# 3. commit + push public repo
cd public
git add .
git commit -m "$msg"
git push origin main
cd ..