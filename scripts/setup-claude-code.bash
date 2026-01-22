#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

echo "Downloading Claude Code"

curl -fsSL https://claude.ai/install.sh | bash

true
