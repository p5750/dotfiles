#!/usr/bin/env bash
set -eux
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if [[ ! -f "${REPO_DIR}/config/git/config_user" ]]; then
  cp "${REPO_DIR}/config/git/config_user.sample" "${REPO_DIR}/config/git/config_user"
fi
