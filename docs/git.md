# Git Configuration

Location: `config/git/`

## Files

- `config` - Main git configuration (committed)
- `config_user` - User-specific settings (gitignored)
- `config_user.sample` - Template for config_user (`[user] name/email`)
- `ignore` - Global gitignore patterns

## Setup

`scripts/setup-git.bash` copies `config_user.sample` to `config_user` if it does not exist. The main `config` includes `config_user` via `[include] path = ~/.config/git/config_user`.

## Configuration Details

### Core Settings

- `color.ui`: true
- `status.showUntrackedFiles`: all
- `diff.algorithm`: histogram
- `fetch.prune`: true
- `ghq.root`: ~/repos

### Aliases

| Alias | Command |
|-------|---------|
| `a` | `add` |
| `b` | `branch -v` |
| `ba` | `branch -av` |
| `br` | `branch -rv` |
| `bl` | `blame` |
| `co` | `checkout` |
| `ci` | `commit -v` |
| `dw` | `diff --color-words` |
| `d` | `diff` |
| `dc` | `diff --cached` |
| `st` | `status -sb` |
| `up` | `pull --rebase` |
| `pr` | `pull --rebase` |
| `rp` | `remote prune` |
| `l` | `log` |
| `ls` | `log --stat` |
| `lp` | `log -p` |

## Global Gitignore (`ignore`)

- `.idea`
- `**/.claude/settings.local.json`
- `**/CLAUDE.local.md`
