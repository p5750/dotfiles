# Claude Code Global Configuration

This file provides global instructions to Claude Code across all projects.

## Language Instructions
- 日本語で指示された場合は日本語で回答してください
- 英語で指示された場合は英語で回答してください
- Respond in the same language as the user's instruction

## General Development Preferences

### Code Style
- Always use spaces for indentation (4 spaces for Python, 2 spaces for JS/TS/YAML)
- Add a newline at the end of all files
- Follow the existing code style in each project
- Keep line length under 100 characters when reasonable

### Git Workflow
- Write clear, concise commit messages in English
- Use conventional commit format when applicable (feat:, fix:, docs:, etc.)
- Never commit secrets, API keys, or sensitive information
- Always review changes before committing

### Language Preferences
- Prefer TypeScript over JavaScript for new projects
- Use modern language features (async/await, destructuring, etc.)
- Prefer functional programming patterns when appropriate

## Tool-Specific Guidelines

### Neovim
- When editing Neovim configs, prefer Lua over Vimscript
- Test configuration changes before committing
- Document complex plugin configurations

### Shell Scripts
- Use bash instead of sh for better features
- Add shebang line: `#!/usr/bin/env bash`
- Use `set -euo pipefail` for error handling
- Quote variables: `"${variable}"` instead of `$variable`

### Python
- Follow PEP 8 style guide
- Use type hints for function signatures
- Prefer f-strings for string formatting
- Use virtual environments for project dependencies

### JavaScript/TypeScript
- Use ESLint and Prettier configurations if present
- Prefer const over let, avoid var
- Use arrow functions for callbacks
- Handle errors with try/catch or .catch()

## Project Management
- Check for existing README, CONTRIBUTING, or similar docs
- Look for .editorconfig, .prettierrc, .eslintrc files
- Respect existing project structure and conventions
- Run tests if available before making changes

## Security Best Practices
- Never hardcode credentials or secrets
- Use environment variables for sensitive data
- Validate and sanitize user inputs
- Be cautious with eval() or similar dynamic code execution

## Performance Considerations
- Optimize for readability first, performance second
- Profile before optimizing
- Consider memory usage for large data sets
- Use appropriate data structures

## Documentation
- Write self-documenting code with clear variable names
- Add comments for complex logic
- Update documentation when changing functionality
- Include examples in documentation when helpful

## Permissions
- `rm` is not allowed. use `git rm` instead
- `find` is not allowed. Use the built-in `Glob` tool for file name search and `Grep` tool for content search instead
- `git add` must specify individual files. `-A`, `--all`, `-u`, `--update`, `.` are not allowed
- `git reset` must specify `--soft` or `--mixed` explicitly. Bare `git reset` is not allowed
- `git -C` is not allowed. `cd` to the target directory first, then run git commands without `-C`
