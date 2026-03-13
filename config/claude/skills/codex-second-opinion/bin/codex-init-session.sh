#!/usr/bin/env bash
set -euo pipefail

# セッション初期化 — REVIEW_ID 生成と .claude/tmp ディレクトリ作成
# Usage: codex-init-session.sh
# 出力: REVIEW_ID を stdout に出力

REVIEW_ID=$(uuidgen | tr '[:upper:]' '[:lower:]' | head -c 8)
mkdir -p .claude/tmp

echo "${REVIEW_ID}"
