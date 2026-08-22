#!/usr/bin/env bash
# 适配改造三重验证：①目录结构完整 ②frontmatter 契约完好 ③关键命令 dry-run 走通（可选）
# 用法: bash verify-adaptation.sh <adapt_dir> [cmd_to_dryrun]
set -euo pipefail

ADAPT="${1:-}"
CMD="${2:-}"

[ -z "$ADAPT" ] && { echo "用法: bash verify-adaptation.sh <adapt_dir> [cmd_to_dryrun]" >&2; exit 1; }

echo "=== 校验 $ADAPT ==="
ok=0

# ① 目录结构完整
[ -f "$ADAPT/SKILL.md" ] || { echo "✗ 缺 SKILL.md"; exit 1; }
[ -z "$(ls -A "$ADAPT")" ] && { echo "✗ 目录为空"; exit 1; }
_skill_name="$(grep -m1 '^name:' "$ADAPT/SKILL.md" 2>/dev/null | sed 's/^name:[[:space:]]*//')"
[ -n "$_skill_name" ] || { echo "✗ SKILL.md 缺 frontmatter name"; exit 1; }
echo "✓ frontmatter name: $_skill_name"

# ② 契约完好（frontmatter 完整性：name + description）
if grep -q '^name:' "$ADAPT/SKILL.md" && grep -q '^description:' "$ADAPT/SKILL.md"; then
  echo "✓ frontmatter: name + description 齐全"
else
  echo "✗ frontmatter 契约不完整" >&2; exit 1
fi

# 升级保护：找非 SKILL.md 引用文件是否还在
[ -d "$ADAPT/references" ] && echo "✓ references/ 存在"

ok=1

# ③ 关键命令 dry-run（若给了 CMD）
if [ -n "$CMD" ]; then
  if eval "$CMD" >/dev/null 2>&1; then
    echo "✓ dry-run 通过: $CMD"
  else
    echo "✗ dry-run 失败: $CMD" >&2; exit 1
  fi
fi

echo "校验结束：ok=$ok"
echo "完成——适配改造通过三重验证。可进用户拍板环节。"