#!/usr/bin/env bash
set -euo pipefail

# zhuge-cto-protocol install v1.2.0
# 安装协议 + 写入清单，诸葛自动发现

SKILL_NAME="zhuge-dyson-task-protocol"
CATEGORY="multi-profile-orchestration"
VERSION="1.2.0"

# 检测安装目录
if [ -n "${HERMES_SKILLS_DIR:-}" ]; then
    TARGET="$HERMES_SKILLS_DIR"
elif [ -d "$HOME/.hermes/skills" ]; then
    TARGET="$HOME/.hermes/skills"
else
    echo "❌ 找不到 Hermes skills 目录"
    echo "   设置 HERMES_SKILLS_DIR 环境变量或确认 ~/.hermes/skills 存在"
    exit 1
fi

DEST="$TARGET/$CATEGORY/$SKILL_NAME"
MANIFEST="$TARGET/protocols.manifest"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$SCRIPT_DIR/protocols/$SKILL_NAME/SKILL.md"

if [ ! -f "$SRC" ]; then
    echo "❌ 找不到协议文件: $SRC"
    exit 1
fi

# 1. 安装技能文件
mkdir -p "$DEST"
cp "$SRC" "$DEST/SKILL.md"

# 2. 写入协议清单
MANIFEST_ENTRY="- name: $SKILL_NAME
  path: $CATEGORY/$SKILL_NAME/SKILL.md
  version: $VERSION
  trigger:
    on_intent: {领域: 技术, 行动: [产出, 分析, 排查]}
    keywords: [部署, 服务器, 节点, 配置, 修复, 排查, 重启, 安装, 迁移, 上线, 备份, 扩容]
  description: 诸葛↔Dyson技术任务协作协议"

if [ -f "$MANIFEST" ]; then
    # 已存在 → 检查是否已有同名条目
    if grep -q "name: $SKILL_NAME" "$MANIFEST"; then
        echo "⚠️  协议已在清单中，跳过写入"
    else
        echo "" >> "$MANIFEST"
        echo "$MANIFEST_ENTRY" >> "$MANIFEST"
    fi
else
    echo "# Hermes Protocols Manifest — 诸葛启动时自动加载" > "$MANIFEST"
    echo "# 安装新协议后自动追加。卸载时手动删除对应条目。" >> "$MANIFEST"
    echo "" >> "$MANIFEST"
    echo "protocols:" >> "$MANIFEST"
    echo "$MANIFEST_ENTRY" >> "$MANIFEST"
fi

echo ""
echo "✅ zhuge-cto-protocol v$VERSION 已安装"
echo "   技能: $DEST/SKILL.md"
echo "   清单: $MANIFEST"
echo ""
echo "   诸葛下次启动自动生效。无需手动加载。"
