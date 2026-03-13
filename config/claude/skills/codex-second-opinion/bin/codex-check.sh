#!/usr/bin/env bash
set -euo pipefail

# Codex CLI の存在と認証状態を確認する

if ! command -v codex &>/dev/null; then
  echo "ERROR: codex コマンドが見つかりません。" >&2
  echo "インストール: npm i -g @openai/codex" >&2
  exit 1
fi

echo "Codex version: $(codex --version)"

if ! codex login status 2>/dev/null; then
  echo "ERROR: Codex CLI が認証されていません。" >&2
  echo "認証: codex login または CODEX_API_KEY 環境変数を設定してください" >&2
  exit 1
fi

echo "Codex CLI: OK"
