#!/usr/bin/env bash
set -euo pipefail

# Codex exec resume ラッパー — 再レビュー実行
# Usage: codex-resume.sh <session_id> <changes_text> <input_file> <output_file>
#   session_id:  前回の Codex セッション ID
#   changes_text: 改善内容のテキスト
#   input_file:   更新済みの入力ファイルパス
#   output_file:  Codex 出力ファイルパス

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 <session_id> <changes_text> <input_file> <output_file>" >&2
  exit 1
fi

SESSION_ID="$1"
CHANGES_TEXT="$2"
INPUT_FILE="$3"
OUTPUT_FILE="$4"

# 出力ディレクトリを確保
mkdir -p "$(dirname "${OUTPUT_FILE}")"

PROMPT="I've revised based on your feedback. Updated content is in ${INPUT_FILE}.

Changes made:
${CHANGES_TEXT}

Please re-review. End with VERDICT: APPROVED or VERDICT: REVISE"

# resume は -o 未対応のため stdout をキャプチャ
# resume 失敗時は exit 2 でフォールバック判定用
if ! codex exec resume "${SESSION_ID}" "${PROMPT}" > "${OUTPUT_FILE}" 2>&1; then
  echo "WARNING: resume failed (session: ${SESSION_ID})" >&2
  exit 2
fi
