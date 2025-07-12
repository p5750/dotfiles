#!/usr/bin/env bash
set -x
# shellcheck source=./scripts/common.bash
source "$(dirname "$0")/common.bash"

if [[ ! -d "$HOME/.ssh" ]]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
fi

if [[ ! -d "$HOME/.gnupg" ]]; then
    mkdir -p "$HOME/.gnupg"
    chmod 700 "$HOME/.gnupg"
fi

mkdir -p \
    "$XDG_CONFIG_HOME" \
    "$XDG_STATE_HOME/zsh" \
    "$XDG_DATA_HOME/zsh/completions"

ln -sfv "$REPO_DIR/config/"* "$XDG_CONFIG_HOME"
ln -sfv "$REPO_DIR/config/zsh/home_zshenv.zsh" "$HOME/.zshenv"

ln -sfv "$REPO_DIR/config/claude" "$HOME/.claude" # workaround: claude code currently ignores XDG Base Directory
