#!/usr/bin/env bash
set -euo pipefail

# zhuge-cto-protocol install
# 安装 诸葛↔Dyson 技术任务协作协议 到Hermes技能目录

SKILL_NAME="zhuge-dyson-task-protocol"
CATEGORY="multi-profile-orchestration"

# 检测安装目录 — 优先级：环境变量 > 默认路径 > 交互
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
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC="$SCRIPT_DIR/protocols/$SKILL_NAME/SKILL.md"

if [ ! -f "$SRC" ]; then
    echo "❌ 找不到协议文件: $SRC"
    exit 1
fi

mkdir -p "$DEST"
cp "$SRC" "$DEST/SKILL.md"

echo "✅ zhuge-cto-protocol v1.0.0 已安装"
echo "   路径: $DEST/SKILL.md"
echo ""
echo "   用法: 在诸葛session里说「加载 zhuge-dyson-task-protocol」"
