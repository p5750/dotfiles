#!/usr/bin/env bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if [[ ! -f "${REPO_DIR}/config/git/config_user" ]]; then
  cp "${REPO_DIR}/config/git/config_user.sample" "${REPO_DIR}/config/git/config_user"
fi

# Install git-wt
go install -v -x github.com/k1LoW/git-wt@latest
