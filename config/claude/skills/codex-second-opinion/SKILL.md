---
name: codex-second-opinion
description: Send the current plan or code to OpenAI Codex CLI for a second-opinion review. Supports plan review, code review, and diff review with iterative feedback loops.
---

# Codex Second Opinion

Claude Code で作成した Plan やコードを OpenAI Codex CLI に送り、セカンドオピニオンを得る。
Codex のフィードバックに基づいて Claude が改善し、再レビューを繰り返す反復型ワークフロー。

詳細な手順は @INSTRUCTIONS.md を参照すること。

## ラッパースクリプト

すべての Codex CLI 呼び出しは `bin/` 配下のラッパースクリプト経由で行う。
`codex exec` を直接実行してはならない。

| スクリプト | 用途 |
|-----------|------|
| `bin/codex-init-session.sh` | セッション初期化 (REVIEW_ID 生成 + `.claude/tmp/` 作成) |
| `bin/codex-check.sh` | Codex CLI の存在・認証確認 |
| `bin/codex-review.sh` | 初回レビュー実行 (`codex exec` ラッパー) |
| `bin/codex-resume.sh` | 再レビュー実行 (`codex exec resume` ラッパー) |
| `bin/codex-prepare-input.sh` | レビュー対象ファイルを `.claude/tmp/` にコピー |

## 一時ファイル

プロジェクト配下の `.claude/tmp/` を使用する（`/tmp/` は使わない）。
