#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

# volta が必要（Homebrew でインストール済みを前提）
if ! command -v volta &> /dev/null; then
  echo "volta is not installed. Please run setup-homebrew.bash first."
  exit 1
fi

# Node.js のインストール（LTS）
volta install node

true
