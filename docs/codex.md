# Codex CLI Configuration

Location: `config/codex/`

## Files

- `config.toml` - Main Codex CLI configuration
- `AGENTS.md` - Agent behavior instructions
- `rules/default.rules` - Execution policy rules (command deny list)

## Setup

Installed via Homebrew (`brew "codex"` in Brewfile).

XDG compliance is configured via `CODEX_HOME` environment variable in `config/zsh/.zshenv`:

```
export CODEX_HOME="$XDG_CONFIG_HOME/codex"
```

## config.toml

| Setting | Value | Description |
|---------|-------|-------------|
| `model` | `gpt-5.3-codex` | Default model |
| `model_reasoning_effort` | `high` | Thorough reasoning for responses |
| `web_search` | `live` | Enable live web search |
| `sandbox_workspace_write.network_access` | `true` | Allow network access in sandbox |

Schema: `https://developers.openai.com/codex/config-schema.json`

## Execution Policy Rules

Location: `config/codex/rules/default.rules`

Mirrors deny rules from `config/claude/settings.json` using Starlark `prefix_rule()` syntax. All rules use `decision = "forbidden"`.

| Category | Forbidden Commands |
|----------|-------------------|
| Destructive | `sudo`, `su`, `rm` |
| Git (dangerous) | `git push -f/--force`, `git reset --hard`, `git clean`, `git tag`, `git -C` |
| Git (broad staging) | `git add ./-A/--all/-u/--update`, `git commit -a/--all` |
| Network | `curl`, `wget`, `nc` |
| Package removal | `npm uninstall/remove` |
| Database | `mysql` |
| File search | `find` |
| Docker (secrets) | `docker compose config/run/exec`, `docker inspect/exec` |

Verify rules:

```bash
codex execpolicy check --pretty \
  --rules ~/.config/codex/rules/default.rules \
  -- <command>
```

## AGENTS.md

Global agent instructions:

- **Language**: Responds in the same language as the user's instruction (Japanese/English)
- **Git Workflow**: Conventional commit format, no secrets, review before committing
- **File Access**: Never read/write `.env*` files or SSH private keys
