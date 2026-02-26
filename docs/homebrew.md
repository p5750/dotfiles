# Homebrew Configuration

Location: `config/homebrew/Brewfile`

## Setup

`scripts/setup-homebrew.bash` installs Homebrew if missing, runs `brew update`, then `brew bundle install --file Brewfile`.

Can be skipped with `$SKIP_HOMEBREW` env var. macOS only.

## Brewfile Ordering Rules

- `brew` formulae を先に記載し、その後に `cask` を記載する
- 各セクション内はアルファベット順にソートする
