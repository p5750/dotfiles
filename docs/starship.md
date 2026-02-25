# Starship Prompt Configuration

Location: `config/starship/starship.toml`
Loaded via: `STARSHIP_CONFIG` env var set in `.zshrc`

## Layout

Left prompt (two lines):
1. `[directory]` -> `[git_branch git_status]`
2. Character prompt (with vim mode indicator)

Right prompt:
- `[cmd_duration]` `[username]` `[time]`

## Modules

### Directory

- Style: bold, fg #2E3440 on bg #88C0D0
- Truncation: 10 segments, not truncated to repo root
- Read-only indicator: lock icon
- Path substitutions: Documents, Downloads, Music, Pictures with icons; `repos/github.com` with GitHub icon

### Git

- Branch: symbol, fg #769ff0 on bg #1d2230
- Status: same color scheme, shows all_status and ahead_behind

### Command Duration

- Min time: 1 second
- Style: #e0af68 (amber)

### Time

- Format: `%R` (HH:MM)
- Always displayed

### Username

- Shows only for non-default user
- Style: white bold

### Character

- Vim command mode indicator: `V` in bold green

### Disabled Modules

- AWS (`[aws] disabled = true`)
- GCloud (`[gcloud] disabled = true`)
