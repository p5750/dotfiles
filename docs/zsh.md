# Zsh Configuration

Location: `config/zsh/`

## Files

- `home_zshenv.zsh` - Symlinked to `~/.zshenv`, sets `ZDOTDIR` and sources `.zshenv`
- `.zshenv` - Environment variables, XDG paths for all tools
- `.zshrc` - Main shell config: PATH, history, sheldon, starship
- `.zshrc.local` - Machine-specific configuration (gitignored)
- `.zshrc-private` - Symlink to private dotfiles repo
- `lazy.zsh` - Deferred loading: tool init, custom functions, sheldon lazy profile
- `alias.zsh` - Shell aliases
- `plugins.toml` - Sheldon plugin manager configuration

## Boot Sequence

1. `~/.zshenv` (home_zshenv.zsh) -> sets `ZDOTDIR=$HOME/.config/zsh`, sources `$ZDOTDIR/.zshenv`
2. `.zshenv` -> XDG vars, Homebrew, language-specific env vars
3. `.zshrc` -> PATH setup, history, zcompile optimization, starship init, completions, sheldon eager profile, sources `.zshrc-private` and `.zshrc.local`
4. `sheldon eager` -> loads `zsh-defer` plugin and `lazy.zsh`
5. `lazy.zsh` (deferred) -> mise, rbenv, atuin, custom functions, sheldon lazy profile
6. `sheldon lazy` -> loads `alias.zsh`, zsh-completions, zsh-autosuggestions, fast-syntax-highlighting

## XDG Compliance

Environment variables set in `.zshenv`:

| Tool | Variables |
|------|-----------|
| Go | `GOPATH`, `GOCACHE`, `GOMODCACHE`, `GOENV`, `GOTELEMETRYDIR`, `GOBIN` |
| Ruby | `GEM_SPEC_CACHE`, `BUNDLE_USER_HOME/CACHE/PLUGIN` |
| Volta | `VOLTA_HOME` |
| Rust | `CARGO_HOME`, `RUSTUP_HOME` |
| Android | `ANDROID_USER_HOME` |
| Docker | `DOCKER_CONFIG` |
| Gradle | `GRADLE_USER_HOME` |
| AWS | `AWS_SHARED_CREDENTIALS_FILE`, `AWS_CONFIG_FILE` |

## Plugin Management (Sheldon)

Configuration in `plugins.toml`. Two profiles:

**eager** (loaded immediately):
- `zsh-defer` (romkatv/zsh-defer) - deferred sourcing
- `compinit` - completion initialization (deferred via zsh-defer inline)
- `lazy` (lazy.zsh) - deferred tool initialization

**lazy** (deferred via zsh-defer):
- `alias` (alias.zsh) - shell aliases
- `zsh-completions` (zsh-users/zsh-completions) - fpath only
- `zsh-autosuggestions` (zsh-users/zsh-autosuggestions)
- `fast-syntax-highlighting` (zdharma/fast-syntax-highlighting)

Sheldon caching: plugin sources are cached to `$XDG_CACHE_HOME/sheldon/` and recompiled only when `plugins.toml` changes.

## PATH Priority (in .zshrc)

1. Homebrew paths (`$(brew --prefix)/bin`, `$(brew --prefix)/sbin`)
2. pyenv shims
3. Volta bin (`$VOLTA_HOME/bin`)
4. Cargo bin (`$CARGO_HOME/bin`)
5. `~/.local/bin`
6. System paths (`/usr/local/bin`, `/usr/bin`, `/bin`, etc.)

## History Configuration

- `HISTFILE`: `$XDG_STATE_HOME/zsh/history`
- `HISTSIZE`: 100,000
- `SAVEHIST`: 1,000,000
- Options: `hist_ignore_all_dups`, `share_history`

## Shell Options

- `auto_cd` - Change directory without cd command
- `AUTO_PARAM_KEYS` - Auto-complete environment variables
- `auto_pushd` - Auto-push directory changes

## Custom Functions (in lazy.zsh)

- `peco-src` (bound to `Ctrl+]`): Browse ghq repositories with peco
- `wt`: Interactive git worktree selection with peco

## Auto-Setup Features (in lazy.zsh)

First-time setup that runs only if tools are missing:
- `git-wt`: installed via `go install` if Go is available
- Node.js: installed via `volta install node` if Volta is available
- Playwright CLI: installed via `volta install @playwright/cli@latest`
- Claude Code skills: installs vercel-react-best-practices and web-design-guidelines via npx

## Aliases (alias.zsh)

- `vi`/`vim` -> `nvim`
- macOS: `ls` -> `gls`, `date` -> `gdate`, `mkdir` -> `gmkdir`, `cp` -> `gcp`, `mv` -> `gmv`, `rm` -> `grm`, `du` -> `gdu`

## Performance Optimization

- `zcompile` wrapper for `source()` function (auto-compiles `.zwc` files)
- Sheldon cache files avoid re-evaluating plugins
- zsh-defer delays heavy tool initialization (mise, rbenv, atuin)
