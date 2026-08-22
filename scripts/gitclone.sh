#!/usr/bin/env bash
# 下载不安装：把候选 skill 克隆到暂存区（D 盘），只读不装。
# 用法: bash gitclone.sh <repo_url> [branch]
set -euo pipefail

SKILLS_STAGING="${SKILLS_STAGING:-D:/ClaudeCode/skills-staging}"
BRANCH="${2:-HEAD}"

[ -z "${1:-}" ] && { echo "用法: bash gitclone.sh <repo_url>" >&2; exit 1; }

URL="$1"
# owner__repo 命名去斜杠+去协议，防路径绕过
OWNER_REPO="$(echo "$URL" | sed -E 's|https?://github.com/||; s|/$||; s|/|__|g; s|[^A-Za-z0-9_.-]|_|g')"
DEST="$SKILLS_STAGING/$OWNER_REPO"

if [ -d "$DEST" ]; then
  echo "已存在，跳过: $DEST"
  exit 0
fi

mkdir -p "$SKILLS_STAGING"
git clone --depth 1 --branch "$BRANCH" "$URL" "$DEST" 2>&1
echo "克隆完成 → $DEST"
echo "下一步：本 skill 第 1 步只读 SKILL.md / references，不安装。"