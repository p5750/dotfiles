#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

echo "Downloading Claude-Command-Suite commands"

commands_to_install=(
  "architecture-review"
  "code-review"
  "security-audit"
  "performance-audit"
  "dependency-audit"
  "explain-code"
  "test-coverage"
)
ccs_repo="qdhenry/Claude-Command-Suite"
ccs_hash="62a6b7ac57341722d43dd8af96804612355f2bc4"
for c in "${commands_to_install[@]}"; do
  echo "Downloading [${c}]"
  curl -o "$REPO_DIR/config/claude/commands/ccsuite/${c}.md" \
    "https://raw.githubusercontent.com/${ccs_repo}/${ccs_hash}/.claude/commands/${c}.md"
done

true
