#!/usr/bin/env bash
set -euo pipefail

CONTEXT=""

if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
  BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
  RECENT=$(git log --oneline -5 2>/dev/null || echo "no commits")
  MODIFIED=$(git diff --name-only 2>/dev/null || echo "none")
  STAGED=$(git diff --cached --name-only 2>/dev/null || echo "none")

  CONTEXT="## Git State at Compaction
Branch: ${BRANCH}
Recent commits:
${RECENT}
Modified files: ${MODIFIED}
Staged files: ${STAGED}"
fi

if [[ -n "${CONTEXT}" ]]; then
  jq -n --arg ctx "${CONTEXT}" '{"additionalContext": $ctx}'
else
  echo '{}'
fi
