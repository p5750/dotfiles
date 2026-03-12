# Claude Code Global Configuration

## Language
- 日本語で指示された場合は日本語で回答してください
- Respond in the same language as the user's instruction

## Git Workflow
- Use conventional commit format (feat:, fix:, docs:, etc.)
- Never commit secrets, API keys, or sensitive information

## Shell Scripts
- Use bash instead of sh
- Add shebang: `#!/usr/bin/env bash`
- Use `set -euo pipefail` for error handling
- Quote variables: `"${variable}"` instead of `$variable`

## Neovim
- Prefer Lua over Vimscript for all configurations

## File Format
- Add a newline at the end of all files
- Use Unix line endings (LF)

## Permissions
- `rm` is not allowed. Use `git rm` instead
- `find` is not allowed. Use `Glob` for file search and `Grep` for content search
- `git add` must specify individual files. `-A`, `--all`, `-u`, `--update`, `.` are not allowed
- `git reset` must specify `--soft` or `--mixed` explicitly. Bare `git reset` is not allowed
- `git -C` is not allowed. `cd` to the target directory first
