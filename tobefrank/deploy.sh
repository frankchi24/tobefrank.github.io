#!/bin/bash
set -e

# 預設 commit 訊息是時間戳
msg="update: $(date)"
[ $# -ge 1 ] && msg="$*"

# 1. build 網站
echo "=== Build Hugo ==="
hugo

# 2. commit + push 內容 repo
echo "=== Push source repo ==="
git add .
git commit -m "$msg" || echo "No changes to commit in source repo"
# 自動偵測目前分支名稱
branch=$(git rev-parse --abbrev-ref HEAD)
git push origin "$branch"

# 3. commit + push public repo
echo "=== Push public repo ==="
cd public
git add .
git commit -m "$msg" || echo "No changes to commit in public repo"
branch_pub=$(git rev-parse --abbrev-ref HEAD)
git push origin "$branch_pub"
cd ..