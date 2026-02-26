# Codex CLI Configuration

Location: `config/codex/`

## Files

- `config.toml` - Main Codex CLI configuration
- `AGENTS.md` - Agent behavior instructions

## Setup

Installed via Homebrew (`brew "codex"` in Brewfile).

XDG compliance is configured via `CODEX_HOME` environment variable in `config/zsh/.zshenv`:

```
export CODEX_HOME="$XDG_CONFIG_HOME/codex"
```

## config.toml

| Setting | Value | Description |
|---------|-------|-------------|
| `model_reasoning_effort` | `high` | Thorough reasoning for responses |
| `web_search` | `live` | Enable live web search |
| `sandbox_workspace_write.network_access` | `true` | Allow network access in sandbox |

Schema: `https://developers.openai.com/codex/config-schema.json`

## AGENTS.md

Global agent instructions:

- **Language**: Responds in the same language as the user's instruction (Japanese/English)
- **Git Workflow**: Conventional commit format, no secrets, review before committing
