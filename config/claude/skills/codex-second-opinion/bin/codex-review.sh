#!/usr/bin/env bash
set -euo pipefail

# Codex exec ラッパー — 初回レビュー実行
# Usage: codex-review.sh <mode> <model> <reasoning> <input_file> <output_file>
#   mode:      plan | code | diff
#   model:     e.g. gpt-5.3-codex
#   reasoning: medium | high | xhigh
#   input_file:  レビュー対象ファイルパス
#   output_file: Codex 出力ファイルパス

if [[ $# -ne 5 ]]; then
  echo "Usage: $0 <mode> <model> <reasoning> <input_file> <output_file>" >&2
  exit 1
fi

MODE="$1"
MODEL="$2"
REASONING="$3"
INPUT_FILE="$4"
OUTPUT_FILE="$5"

if [[ ! -f "${INPUT_FILE}" ]]; then
  echo "ERROR: 入力ファイルが見つかりません: ${INPUT_FILE}" >&2
  exit 1
fi

# モードに応じたプロンプトを生成
case "${MODE}" in
  plan)
    PROMPT=$(cat <<'PROMPT_EOF'
Review the implementation plan in ${INPUT_FILE}.

Evaluate:
1. Correctness — Will this plan achieve the stated goals?
2. Risks — Edge cases, data loss, race conditions?
3. Missing steps — Anything forgotten or underspecified?
4. Alternatives — Is there a simpler or more robust approach?
5. Security — Any security or privacy concerns?
6. Performance — Scalability issues or bottlenecks?

Be specific and actionable. Reference line numbers or section names.

If the plan is solid: end with VERDICT: APPROVED
If changes needed: end with VERDICT: REVISE
PROMPT_EOF
    )
    # 変数を展開
    PROMPT="${PROMPT//\$\{INPUT_FILE\}/${INPUT_FILE}}"
    ;;
  code)
    PROMPT=$(cat <<'PROMPT_EOF'
Review the code described in ${INPUT_FILE}.

Evaluate:
1. Bugs — Logic errors, off-by-one, null/undefined handling
2. Security — Injection, auth bypass, data exposure
3. Performance — N+1 queries, memory leaks, unnecessary allocations
4. Maintainability — Naming, complexity, dead code, duplication
5. Testing gaps — Missing edge case coverage
6. Best practices — Idiomatic patterns for the language/framework

Be specific: cite file paths and line numbers. Suggest concrete fixes.

If the code is production-ready: end with VERDICT: APPROVED
If improvements needed: end with VERDICT: REVISE
PROMPT_EOF
    )
    PROMPT="${PROMPT//\$\{INPUT_FILE\}/${INPUT_FILE}}"
    ;;
  diff)
    PROMPT=$(cat <<'PROMPT_EOF'
Review the git diff in ${INPUT_FILE}.

Evaluate:
1. Correctness — Does this change do what it intends?
2. Regressions — Could this break existing functionality?
3. Missing changes — Are there files that should also be updated?
4. Test coverage — Are the changes adequately tested?
5. Security — Any new attack surface introduced?

Be specific: reference diff hunks and file paths.

If the changes look good: end with VERDICT: APPROVED
If improvements needed: end with VERDICT: REVISE
PROMPT_EOF
    )
    PROMPT="${PROMPT//\$\{INPUT_FILE\}/${INPUT_FILE}}"
    ;;
  *)
    echo "ERROR: 不明なモード: ${MODE} (plan/code/diff のいずれかを指定)" >&2
    exit 1
    ;;
esac

# 出力ディレクトリを確保
mkdir -p "$(dirname "${OUTPUT_FILE}")"

# Codex exec 実行
codex exec \
  -c model="${MODEL}" \
  -c model_reasoning_effort="${REASONING}" \
  --sandbox read-only \
  -o "${OUTPUT_FILE}" \
  "${PROMPT}"
