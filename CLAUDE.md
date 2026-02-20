# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration for various development tools and applications on macOS, including:
- Neovim (primary editor with extensive plugin ecosystem)
- WezTerm (terminal emulator)
- Zsh (shell with sheldon for plugin management and zsh-defer for lazy loading)
- Git configuration
- Hammerspoon (macOS automation)
- Starship (shell prompt)
- LazyGit (TUI for git)
- Homebrew packages
- Claude Code configuration
- Atuin (shell history management)

## Installation and Setup Commands

```bash
# Initial installation (from remote)
curl -sL https://raw.githubusercontent.com/p5750/dotfiles/main/install.sh | sh

# Manual setup from cloned repository
./scripts/setup.bash

# Individual setup scripts
./scripts/setup-homebrew.bash  # Install Homebrew packages from config/homebrew/Brewfile
./scripts/setup-links.bash     # Create symlinks to config files
./scripts/setup-mac.bash       # macOS-specific settings
# Note: scripts/common.bash provides shared variables and functions
```

## Repository Architecture

### Directory Structure
- `config/` - All application configurations (symlinked to appropriate locations)
  - `nvim/` - Neovim configuration using Lua and lazy.nvim plugin manager
  - `wezterm/` - WezTerm terminal configuration
  - `zsh/` - Zsh shell configuration with zsh-defer for lazy loading
  - `git/` - Git global configuration
  - `homebrew/` - Brewfile with package dependencies
  - `starship/` - Shell prompt configuration
  - `lazygit/` - LazyGit configuration
  - `hammerspoon/` - macOS automation scripts
  - `claude/` - Claude Code configuration and project history

### Key Design Patterns
1. **XDG Base Directory Compliance**: Uses `$XDG_CONFIG_HOME`, `$XDG_DATA_HOME`, `$XDG_STATE_HOME`
2. **Symlink-based Management**: All configs are symlinked from the repo to their appropriate locations
3. **Modular Configuration**: Each tool has its own directory under `config/`
4. **Shell Script Automation**: Installation and setup automated via bash scripts
5. **Performance Optimization**: Zsh uses zsh-defer for lazy loading of heavy plugins

### Neovim Configuration Structure
- `init.lua` - Entry point that loads three modules
- `lua/config/` - Core configuration (options, commands, lazy.nvim setup)
- `lua/plugins/` - Individual plugin configurations including:
  - `claude-code.lua` - Claude Code integration
  - `diffview.lua` - Git diff visualization
  - `git-blame.lua` - Inline git blame
  - `gitgutter.lua` - Git change indicators
- `after/lsp/` - LSP-specific configurations
- Uses lazy.nvim for plugin management with lock file (`lazy-lock.json`)

### Zsh Configuration Details
- Uses `sheldon` for plugin management with `plugins.toml`
- Implements lazy loading with `zsh-defer` for performance
- Plugin profiles: `eager` (immediate load) and `lazy` (deferred load)
- Sources `common.bash` for shared environment setup

### Development Tools (via Homebrew)
Key development tools managed through Brewfile:
- **Version Managers**: mise (multi-language), rbenv (Ruby), volta (Node.js)
- **Search/Find Tools**: fd (modern find), ripgrep (rg)
- **Shell Enhancements**: atuin (history), zoxide (smart cd)
- **Security**: sops (encryption), gnupg
- **And many more development utilities**

## Development Rules

### Git Commit Guidelines
- Commit messages should be written in English
- When changing individual application settings under config/, prefix the commit message with the application name in brackets. Example: `[nvim] fix: LSP config`

### File Format Rules
- Always add a newline at the end of files unless explicitly told not to
- Use Unix line endings (LF)

### Shell Script Development
- All setup scripts use bash (not sh)
- Scripts use `set -x` for debugging and `set -eux` for strict error handling
- Common variables and functions are sourced from `scripts/common.bash`
- Use proper quoting for variables: `"${variable}"`

### Configuration Updates
- Test changes locally before committing
- Update lazy-lock.json when adding/updating Neovim plugins
- Ensure symlinks work correctly after configuration changes
- Run relevant setup scripts to verify installation works
