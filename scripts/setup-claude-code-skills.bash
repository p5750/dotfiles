#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

# npx が必要
if ! command -v npx &> /dev/null; then
  echo "npx is not installed. Please run setup-volta.bash first."
  exit 1
fi

# インストールするスキルの一覧
skills_to_install=(
  "vercel-react-best-practices"
  "web-design-guidelines"
)

# スキルをグローバルにインストール
for skill in "${skills_to_install[@]}"; do
  echo "Installing skill: ${skill}"
  npx add-skill vercel-labs/agent-skills -a claude-code -g -s "${skill}" -y
done

true
