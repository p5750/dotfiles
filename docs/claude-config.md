# Claude Code Configuration

Location: `config/claude/` (symlinked to both `$XDG_CONFIG_HOME/claude` and `~/.claude`)

## Symlink Workaround

Claude Code does not respect XDG Base Directory. `setup-links.bash` creates an additional symlink:

```
ln -sfv "$REPO_DIR/config/claude" "$HOME/.claude"
```

## Key Files

- `settings.json` - Permissions, hooks, model settings
- `CLAUDE.md` - Global Claude Code instructions (at `~/.claude/CLAUDE.md`)
- `statusline.sh` - Shell statusline script
- `commands/` - Custom slash commands
  - `create-sow.md` - Custom SOW creation command
  - `ccsuite/` - Claude Command Suite (downloaded by setup-claude-code-commands.bash)

## settings.json Overview

### Permissions (Allow)

- Web search, GitHub fetch
- Common bash read commands (ls, rg, grep, sort, test, which)
- Git operations (add, pull, checkout, cherry-pick, commit, status, log, diff, show, blame, branch, switch, fetch, stash, revert, merge, push, soft/mixed reset, rm, mv)
- GitHub CLI (pr list, pr view, pr diff)
- Package managers (npm, pnpm, yarn: install, add, run, test, start)
- Ruby tools (bundle exec rubocop)
- System (afplay, docker compose)

### Permissions (Deny)

- Destructive: sudo, su, rm, force push, hard reset, git clean, git tag
- Broad staging: `git add .`, `git add -A`, `git add --all`, `git commit -a`
- Network: curl, wget, nc
- Secrets: Read .env files, Read SSH keys
- Docker exec/inspect, mysql

### Hooks

- **Stop**: plays `Glass.aiff` sound
- **Notification**: plays `Blow.aiff` sound

### Other Settings

- `alwaysThinkingEnabled`: true
- `model`: opus
- `statusLine`: runs `~/.claude/statusline.sh`

## Claude Command Suite

Downloaded from `qdhenry/Claude-Command-Suite` (pinned to commit `62a6b7a`) by `setup-claude-code-commands.bash`:

- `architecture-review`
- `code-review`
- `security-audit`
- `performance-audit`
- `dependency-audit`
- `explain-code`
- `test-coverage`

## Setup Scripts

- `scripts/setup-claude-code.bash` - Installs Claude Code CLI
- `scripts/setup-claude-code-commands.bash` - Downloads command suite files
