---
name: codex-second-opinion-instructions
description: Codex Second Opinion スキルの詳細な実行手順
---

# Codex Second Opinion — 実行手順

## Prerequisites

起動時に以下で Codex CLI の状態を確認する:

```bash
~/.claude/skills/codex-second-opinion/bin/codex-check.sh
```

失敗した場合はユーザーに案内して終了する。

---

## Step 1: レビューモード選択

AskUserQuestion を使い、以下から選択させる:

**レビュー対象:**
- **Plan Review** — 現在の会話コンテキストにある実装計画をレビュー
- **Code Review** — 指定ディレクトリ/ファイルのコードをレビュー
- **Diff Review** — git diff（未コミット変更 or 特定ブランチ比較）をレビュー

**Codex モデル:**
- `gpt-5.3-codex` (default, 最高性能)
- `gpt-5.2-codex`
- `gpt-5-codex`

**推論レベル（model_reasoning_effort）:**
- `medium` — 通常タスク (default)
- `high` — 複雑な問題
- `xhigh` — 最も深い推論（時間がかかる）

---

## Step 2: セッション準備

```bash
REVIEW_ID=$(~/.claude/skills/codex-second-opinion/bin/codex-init-session.sh)
```

一時ファイルパス:
- レビュー対象: `.claude/tmp/claude-input-${REVIEW_ID}.md`
- Codex 出力: `.claude/tmp/codex-output-${REVIEW_ID}.md`

---

## Step 3: レビュー対象の準備

### Plan Review の場合
現在の会話コンテキストにある Plan を `.claude/tmp/claude-input-${REVIEW_ID}.md` に書き出す。
Plan が存在しない場合はユーザーに何をレビューしたいか確認する。

### Code Review の場合
AskUserQuestion でレビュー対象のパス（ディレクトリ or ファイル）を確認する。
対象パスの情報を `.claude/tmp/claude-input-${REVIEW_ID}.md` に記載する（ファイル一覧とコンテキスト）。

### Diff Review の場合
以下のいずれかで diff を取得し、ファイルに書き出す:

```bash
# 未コミット変更
git diff HEAD > .claude/tmp/claude-input-${REVIEW_ID}.md

# ブランチ比較
git diff main...HEAD > .claude/tmp/claude-input-${REVIEW_ID}.md
```

---

## Step 4: Codex に初回レビュー依頼（Round 1）

ラッパースクリプト経由でレビューを実行する:

```bash
~/.claude/skills/codex-second-opinion/bin/codex-review.sh \
  <mode> <model> <reasoning> \
  .claude/tmp/claude-input-${REVIEW_ID}.md \
  .claude/tmp/codex-output-${REVIEW_ID}.md
```

- `<mode>`: `plan` / `code` / `diff`
- `<model>`: 選択されたモデル名
- `<reasoning>`: 選択された推論レベル

**重要:** Codex の出力から session id を取得し `CODEX_SESSION_ID` として保持する。

---

## Step 5: レビュー結果の確認と表示

1. `.claude/tmp/codex-output-${REVIEW_ID}.md` を読み取る
2. ユーザーに以下の形式で表示:

```
## 🔍 Codex Second Opinion — Round N (model: <model>)

[Codex のフィードバック内容]

**Verdict:** APPROVED ✅ / REVISE 🔄
```

3. VERDICT の判定:
   - **APPROVED** → Step 7（Claude の独自分析と比較）へ
   - **REVISE** → Step 6（改善ループ）へ
   - **判定なし but ポジティブ** → APPROVED として扱う
   - **Round 5 到達** → Step 7 へ（未承認の旨を注記）

---

## Step 6: 改善と再レビュー（Round 2-5）

1. Codex のフィードバックに基づき、Claude が Plan/コードを改善する
2. 改善内容をユーザーに簡潔に報告:

```
### 改善内容（Round N）
- [変更点1: 理由]
- [変更点2: 理由]
- [ユーザー要件と矛盾するため見送り: 指摘内容]
```

3. 改善した内容で `.claude/tmp/claude-input-${REVIEW_ID}.md` を更新
4. ラッパースクリプト経由で再レビュー:

```bash
~/.claude/skills/codex-second-opinion/bin/codex-resume.sh \
  "${CODEX_SESSION_ID}" \
  "改善した項目リスト" \
  .claude/tmp/claude-input-${REVIEW_ID}.md \
  .claude/tmp/codex-output-${REVIEW_ID}.md
```

resume 失敗時（exit 2）は `codex-review.sh` にフォールバックし、過去ラウンドのコンテキストを入力ファイルに含める。

5. Step 5 に戻る

---

## Step 7: 最終レポート — Claude × Codex 比較分析

Codex レビュー完了後、Claude 自身も独自にレビューを行い、**比較表**を作成する。
これがセカンドオピニオンの価値を最大化するポイント。

```
## 📋 Second Opinion Report

### Codex の指摘サマリー
[Codex が挙げた主要な指摘事項]

### Claude の独自分析
[Claude が独自に見つけた追加の懸念点・改善点]

### 比較表

| 観点 | Codex の評価 | Claude の評価 | 一致/相違 |
|------|-------------|-------------|----------|
| ... | ... | ... | ✅一致 / ⚠️相違 |

### 相違点の考察
[両者の見解が異なる点について、それぞれの根拠と推奨アクション]

### 最終ステータス
- Codex: APPROVED ✅ / REVISE 🔄（N ラウンド）
- Claude: [独自の判定]
- **推奨アクション:** [次に何をすべきか]
```

---

## Step 8: 一時ファイルについて

一時ファイル (`.claude/tmp/claude-input-${REVIEW_ID}.md`, `.claude/tmp/codex-output-${REVIEW_ID}.md`) は
手動削除は行わない。`.claude/tmp/` は `.gitignore` で除外されている。
セッション ID 付きファイル名のため、並行実行時も衝突しない。

---

## ルール

- Claude は Codex のフィードバックに基づき**実際に改善を行う**（メッセンジャーではない）
- ユーザーの明示的な要件と矛盾する指摘は見送り、その旨を報告する
- すべての Codex CLI 呼び出しはラッパースクリプト経由で行う — `codex exec` を直接実行しない
- 最大 5 ラウンドで打ち切り（無限ループ防止）
- 各ラウンドのフィードバックと改善内容をユーザーに透明に見せる
- Codex CLI 未インストール/認証エラー時は案内メッセージを出して終了
- Plan Review 時に Plan が存在しない場合はユーザーに確認する
