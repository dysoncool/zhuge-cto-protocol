#!/usr/bin/env bash
set -euo pipefail

# zhuge-cto-protocol install v1.3.0
# 安装协议到Hermes技能目录。input-router已内置桥接，安装即生效。

SKILL_NAME="zhuge-cto-protocol"
CATEGORY="multi-profile-orchestration"
VERSION="1.3.0"

# 检测技能安装目录
if [ -n "${HERMES_SKILLS_DIR:-}" ]; then
    SKILLS_DIR="$HERMES_SKILLS_DIR"
elif [ -d "$HOME/.hermes/skills" ]; then
    SKILLS_DIR="$HOME/.hermes/skills"
else
    echo "❌ 找不到 Hermes skills 目录"
    echo "   设置 HERMES_SKILLS_DIR 环境变量或确认 ~/.hermes/skills 存在"
    exit 1
fi

DEST="$SKILLS_DIR/$CATEGORY/$SKILL_NAME"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$SCRIPT_DIR/protocols/$SKILL_NAME/SKILL.md"

if [ ! -f "$SRC" ]; then
    echo "❌ 找不到协议文件: $SRC"
    exit 1
fi

# 1. 安装技能文件
mkdir -p "$DEST"
cp "$SRC" "$DEST/SKILL.md"

# 2. 写入清单
MANIFEST="$SKILLS_DIR/protocols.manifest"
MANIFEST_ENTRY="- name: $SKILL_NAME
  version: $VERSION
  installed: $(date +%Y-%m-%d)"

if [ -f "$MANIFEST" ]; then
    if ! grep -q "name: $SKILL_NAME" "$MANIFEST"; then
        echo "$MANIFEST_ENTRY" >> "$MANIFEST"
    fi
else
    echo "# Protocols Manifest" > "$MANIFEST"
    echo "$MANIFEST_ENTRY" >> "$MANIFEST"
fi

echo ""
echo "✅ zhuge-cto-protocol v$VERSION 已安装"
echo "   路径: $DEST/SKILL.md"
echo ""
echo "   触发方式：input-router 检测到技术执行任务 → 自动加载本协议"
echo "   卸载方式：删除 $DEST + 删除 manifest 中对应条目"
