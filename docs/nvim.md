# Neovim Configuration

Location: `config/nvim/`

## Architecture

- Entry point: `init.lua` loads three modules via `require()`:
  1. `config.options` - Editor settings, keymaps, autocommands
  2. `config.commands` - Custom user commands
  3. `config.lazy` - Plugin manager bootstrap and setup

## Core Configuration (`lua/config/`)

### options.lua

- Leader key: Space (`vim.g.mapleader = " "`)
- Local leader: Backslash (`vim.g.maplocalleader = "\\"`)
- Netrw disabled (replaced by nvim-tree)
- Tab/indent: 2 spaces, expandtab
- Line numbers: absolute + relative
- Clipboard: system clipboard (`unnamedplus,unnamed`)
- Color column at 80, cursorline enabled
- Swap/backup files disabled, undofile enabled
- Update time: 300ms

Key mappings:

| Mode | Key | Action |
|------|-----|--------|
| Insert | `jj` | ESC |
| Normal | `tt` | Open terminal |
| Normal | `tx` | Open terminal in horizontal split |
| Normal | `<leader>hd` | DiffviewOpen HEAD~1 |
| Normal | `<leader>hf` | DiffviewFileHistory (current file) |
| Normal | `<leader>bl` | GitBlameToggle |
| Normal | `grd` | LSP go to definition |

Autocommands:
- `TermOpen` -> auto startinsert
- `FileType` -> folding (Lua: treesitter expr, Ruby: indent, others: manual)
- `*.slim` files -> set ft=slim

### commands.lua

| Command | Keymap | Description |
|---------|--------|-------------|
| `CpAbsPath` | `<leader>cpa` | Copy absolute file path to clipboard |
| `CpRelPath` | `<leader>cpr` | Copy relative file path to clipboard |

### lazy.lua

- Bootstraps lazy.nvim from GitHub (stable branch)
- Auto-imports all files from `plugins/` directory
- Plugin update checker: enabled (silent)

## Plugins (`lua/plugins/`)

| File | Plugin | Purpose |
|------|--------|---------|
| `lsp.lua` | nvim-lspconfig + Mason | LSP with mason-managed servers (lua_ls, rust_analyzer, clangd, zls, ts_ls, phpactor, bashls) plus rbenv-managed ruby_lsp and rubocop |
| `telescope.lua` | telescope.nvim (0.1.8) | Fuzzy finder: `<C-p>` files, `<leader>s` live grep, `<leader>;` buffers. Vertical layout |
| `nvim-tree.lua` | nvim-tree.lua | File explorer (width 30), auto-finds current file, custom git glyphs |
| `completion.lua` | nvim-cmp + autoclose.nvim | Completion from LSP, buffer, path sources |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting for typescript, tsx, cpp, yaml, lua, vimdoc, vue, json, markdown |
| `colorscheme.lua` | tokyonight.nvim | Tokyo Night (night variant), transparent background |
| `lualine.lua` | lualine.nvim | Status line with relative file path and LSP progress |
| `claude-code.lua` | claude-code.nvim | Claude Code integration (default setup) |
| `lazygit.lua` | lazygit.nvim | `<leader>lg` opens LazyGit |
| `diffview.lua` | diffview.nvim | Git diff viewer |
| `git-blame.lua` | git-blame.nvim | Inline git blame (disabled by default, toggled via `<leader>bl`) |
| `gitgutter.lua` | vim-gitgutter | Git change indicators in sign column |
| `slim.lua` | vim-slim | Slim template syntax support |

## LSP Configuration (`after/lsp/`)

| File | Server | Details |
|------|--------|---------|
| `ruby_lsp.lua` | ruby_lsp | Formatter: standard, linter: standard, runs via `$RBENV_ROOT/shims/ruby-lsp` |
| `rubocop.lua` | rubocop | Runs via `bundle exec rubocop --lsp` |
| `ts_ls.lua` | ts_ls | Relative import preference, auto type acquisition enabled |

## Notes

- After adding/updating plugins, `lazy-lock.json` must be updated
- Prefer Lua over Vimscript for all configurations
- Plugin configurations follow lazy.nvim spec format
