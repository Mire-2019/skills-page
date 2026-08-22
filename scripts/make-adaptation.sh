#!/usr/bin/env bash
# 适配改造：按 4 档（①组装 ②改造 ③定制 ④只借鉴）生成改造目标。
# 注意：本脚本做「加版权头/加约束段」这类确定性改写；语义级整合仍由 agent 现场判断。
# 用法: bash make-adaptation.sh <src_dir> <target_dir> <type: assemble|modify|custom|borrow> [source_name]
set -euo pipefail

SRC="${1:-}"
DEST="${2:-}"
TYPE="${3:-}"
SOURCE_NAME="${4:-}"

[ -z "$SRC" ] || [ -z "$DEST" ] || [ -z "$TYPE" ] && \
  { echo "用法: bash make-adaptation.sh <src_dir> <target_dir> <assemble|modify|custom|borrow> [source_name]" >&2; exit 1; }

SOURCE_NAME="${SOURCE_NAME:-$(echo "$SRC" | sed -E 's|.*/([^/]+)/?$|\1|')}"

case "$TYPE" in
  assemble|modify|borrow)
    mkdir -p "$DEST"
    # ①组装/②改造：把内容搬进目标目录后再改；④只借鉴只落借鉴笔记
    cp -r "$SRC"/. "$DEST"/
    echo "copied: $SRC → $DEST"

    # frontmatter 版本化 + 来源标注（④borrow 不搬正文只记笔记，跳过）
    echo "source: $SOURCE_NAME" >> "$DEST/SKILL.md"
    if [ -f "$DEST/SKILL.md" ]; then
      if ! grep -q '^version:' "$DEST/SKILL.md"; then
        sed -i '1a version: 1.0.0' "$DEST/SKILL.md"
        echo "frontmatter: 补 version: 1.0.0"
      fi
    fi
    echo "SKILL.md: 追加 source: $SOURCE_NAME"
    ;;
  custom)
    # ③定制：外部只参考，主体重建——由 agent 在目标目录新建 SKILL.md，脚本只建目录
    mkdir -p "$DEST"
    echo "custom 模式：目标目录已建，请 agent 在 $DEST 新建本地版 SKILL.md（外部仅作参考）"
    ;;
  *)
    echo "未知类型: $TYPE（应为 assemble|modify|custom|borrow）" >&2
    exit 1
    ;;
esac

echo "完成。下一步：三重验证（scripts/verify-adaptation.sh）。"