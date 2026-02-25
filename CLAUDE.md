# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository that manages configuration for various development tools and applications on macOS, including:
- Neovim (primary editor) - see @docs/nvim.md
- WezTerm (terminal emulator) - see @docs/wezterm.md
- Zsh (shell with sheldon + zsh-defer) - see @docs/zsh.md
- Git configuration - see @docs/git.md
- Hammerspoon (macOS automation) - see @docs/hammerspoon.md
- Starship (shell prompt) - see @docs/starship.md
- LazyGit (TUI for git) - see @docs/lazygit.md
- Homebrew packages - see @docs/homebrew.md
- Claude Code configuration - see @docs/claude-config.md
- Atuin (shell history management)

## Installation and Setup

See @docs/install-scripts.md for full details on installation scripts.

```bash
curl -sL https://raw.githubusercontent.com/p5750/dotfiles/main/install.sh | sh
```

## Repository Architecture

### Directory Structure
- `config/` - All application configurations (symlinked to appropriate locations)
  - `nvim/` - Neovim configuration (@docs/nvim.md)
  - `wezterm/` - WezTerm terminal configuration (@docs/wezterm.md)
  - `zsh/` - Zsh shell configuration (@docs/zsh.md)
  - `git/` - Git global configuration (@docs/git.md)
  - `homebrew/` - Brewfile with package dependencies (@docs/homebrew.md)
  - `starship/` - Shell prompt configuration (@docs/starship.md)
  - `lazygit/` - LazyGit configuration (@docs/lazygit.md)
  - `hammerspoon/` - macOS automation scripts (@docs/hammerspoon.md)
  - `claude/` - Claude Code configuration (@docs/claude-config.md)
  - `mise/` - mise runtime version manager settings

### Key Design Patterns
1. **XDG Base Directory Compliance**: Uses `$XDG_CONFIG_HOME`, `$XDG_DATA_HOME`, `$XDG_STATE_HOME`
2. **Symlink-based Management**: All configs are symlinked from the repo to their appropriate locations
3. **Modular Configuration**: Each tool has its own directory under `config/`
4. **Shell Script Automation**: Installation and setup automated via bash scripts
5. **Performance Optimization**: Zsh uses zsh-defer for lazy loading of heavy plugins

## Development Rules

### Git Commit Guidelines
- Commit messages should be written in English
- When changing individual application settings under config/, prefix the commit message with the application name in brackets. Example: `[nvim] fix: LSP config`

### File Format Rules
- Always add a newline at the end of files unless explicitly told not to
- Use Unix line endings (LF)

### Configuration Updates
- Test changes locally before committing
- Update lazy-lock.json when adding/updating Neovim plugins
- Ensure symlinks work correctly after configuration changes
- Run relevant setup scripts to verify installation works
