#!/usr/bin/env bash
set -euo pipefail

# レビュー対象ファイルを .claude/tmp/ にコピー
# Usage: codex-prepare-input.sh <source_file> <review_id>
# 出力: コピー先パスを stdout に出力

SOURCE_FILE="${1:?Usage: codex-prepare-input.sh <source_file> <review_id>}"
REVIEW_ID="${2:?Usage: codex-prepare-input.sh <source_file> <review_id>}"
DEST=".claude/tmp/claude-input-${REVIEW_ID}.md"

if [[ ! -f "${SOURCE_FILE}" ]]; then
  echo "Error: source file not found: ${SOURCE_FILE}" >&2
  exit 1
fi

mkdir -p .claude/tmp
cp "${SOURCE_FILE}" "${DEST}"

echo "${DEST}"
