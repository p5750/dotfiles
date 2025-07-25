#!/usr/bin/env bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

/bin/bash "$CUR_DIR/setup-homebrew.bash"
/bin/bash "$CUR_DIR/setup-links.bash"
/bin/bash "$CUR_DIR/setup-git.bash"
/bin/bash "$CUR_DIR/setup-mac.bash"
/bin/bash "$CUR_DIR/setup-claude-code-commands.bash"
