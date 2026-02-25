# Installation and Setup Scripts

Location: `scripts/` and `install.sh` (root)

## Quick Start

```bash
# Remote install (clones repo to ~/repos/github.com/p5750/dotfiles)
curl -sL https://raw.githubusercontent.com/p5750/dotfiles/main/install.sh | sh

# Manual setup from cloned repository
./scripts/setup.bash
```

## install.sh (Root)

- Uses `/bin/sh` (POSIX shell)
- Default install directory: `$HOME/repos/github.com/p5750/dotfiles`
- Clones the repo if absent, or runs `git pull` if already present
- Delegates to `scripts/setup.bash`

## Shell Script Conventions

- All setup scripts use bash (not sh)
- Scripts use `set -x` for debugging and `set -eux` for strict error handling
- Common variables and functions are sourced from `scripts/common.bash`
- Use proper quoting for variables: `"${variable}"`

## scripts/common.bash

Shared variables sourced by all setup scripts:

- `CUR_DIR` - scripts directory path
- `REPO_DIR` - repository root path
- `XDG_CONFIG_HOME` (default: `$HOME/.config`)
- `XDG_DATA_HOME` (default: `$HOME/.local/share`)
- `XDG_STATE_HOME` (default: `$HOME/.local/state`)
- Uses `set -x` for debug output

## scripts/setup.bash (Orchestrator)

Uses `set -eux` for strict error handling. Execution order:

1. `setup-homebrew.bash` - Install/update Homebrew and packages
2. `setup-links.bash` - Create all symlinks
3. `setup-git.bash` - Initialize git user config
4. `setup-mac.bash` - Apply macOS system preferences
5. `setup-claude-code.bash` - Install Claude Code CLI
6. `setup-claude-code-commands.bash` - Download Claude Command Suite

## Individual Scripts

### setup-homebrew.bash

- macOS only (exits on non-Darwin)
- Skippable via `$SKIP_HOMEBREW` env var
- Installs Homebrew if missing
- Runs `brew update` then `brew bundle install` from Brewfile

### setup-links.bash

Creates directories:
- `~/.ssh` and `~/.gnupg` (mode 700)
- `$XDG_CONFIG_HOME`, `$XDG_STATE_HOME/zsh`, `$XDG_DATA_HOME/zsh/completions`

Creates symlinks:

| Source (Repo) | Target (System) |
|---|---|
| `config/*` | `$XDG_CONFIG_HOME/` (bulk link) |
| `config/zsh/home_zshenv.zsh` | `~/.zshenv` |
| `config/claude` | `~/.claude` (XDG workaround) |

### setup-git.bash

- Copies `config/git/config_user.sample` to `config/git/config_user` if not already present
- User must edit `config_user` with actual name/email

### setup-mac.bash

macOS system preferences via `defaults write`:

- **Appearance**: Dark mode enabled
- **Finder**: Show all files, path bar, tab view, home directory default, list view, all extensions
- **Dock**: Right side, tile size 31, no magnification, no recent items
- **Menu bar**: Battery percentage, Japanese date format
- **Mission Control**: Bottom-right hot corner -> Desktop, no auto-rearrange spaces
- **Network**: Disable .DS_Store on network disks
- **Screenshots**: No shadow, save to Downloads
- **Hammerspoon**: Config path set to `$XDG_CONFIG_HOME/hammerspoon/init.lua`
- Restarts Dock, Finder, SystemUIServer to apply

### setup-claude-code.bash

- Downloads and installs Claude Code CLI via `curl https://claude.ai/install.sh | bash`

### setup-claude-code-commands.bash

- Downloads 7 commands from `qdhenry/Claude-Command-Suite` (pinned to commit `62a6b7a`)
- Commands: architecture-review, code-review, security-audit, performance-audit, dependency-audit, explain-code, test-coverage
- Installed to: `config/claude/commands/ccsuite/`
