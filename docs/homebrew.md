# Homebrew Configuration

Location: `config/homebrew/Brewfile`

## Setup

`scripts/setup-homebrew.bash` installs Homebrew if missing, runs `brew update`, then `brew bundle install --file Brewfile`.

Can be skipped with `$SKIP_HOMEBREW` env var. macOS only.

## Packages by Category

### Shell & Terminal

- `atuin` - Shell history sync/search
- `sheldon` - Zsh plugin manager
- `starship` - Cross-shell prompt
- `fzf` - Fuzzy finder
- `peco` - Interactive filtering

### Version Managers

- `mise` - Multi-language runtime manager
- `rbenv` - Ruby version manager
- `volta` - Node.js version manager
- `rustup` - Rust toolchain manager

### Search & File Tools

- `fd` - Modern `find` replacement
- `ripgrep` - Fast grep (`rg`)
- `coreutils` - GNU core utils (for macOS)
- `grep` - GNU grep

### Development Tools

- `gh` - GitHub CLI
- `ghq` - Remote repository management
- `go` - Go programming language
- `neovim` - Text editor
- `lazygit` - TUI for git
- `luarocks` - Lua package manager
- `ctags` - Code indexing
- `shellcheck` - Shell script linter
- `hadolint` - Dockerfile linter
- `jq` - JSON processor
- `jnv` - Interactive JSON navigator

### Infrastructure & Cloud

- `awscli` - AWS CLI
- `aws-vault` - AWS credential management
- `kustomize` - Kubernetes customization
- `sops` - Secrets management

### System & Network

- `htop` - Process monitor
- `pv` - Pipe viewer
- `rsync` - File sync
- `wget` - HTTP download
- `nkf` - Character encoding converter
- `watch` - Periodic command execution
- `zstd` - Compression

### Media

- `ffmpeg` - Media processing
- `vips` - Image processing

## Cask Applications

| Cask | Description |
|------|-------------|
| `1password` / `1password-cli` | Password manager |
| `firefox` | Web browser |
| `font-hack-nerd-font` | Primary terminal font |
| `font-jetbrains-mono-nerd-font` | Fallback terminal font |
| `font-plemol-jp-nf` | Japanese fallback font |
| `google-chrome` | Web browser |
| `google-japanese-ime` | Japanese input method |
| `hammerspoon` | macOS automation |
| `notion` | Note-taking |
| `session-manager-plugin` | AWS Session Manager |
| `slack` | Communication |
| `wezterm` | Terminal emulator |
| `zoom` | Video conferencing |
| `sequel-ace` | MySQL client |
