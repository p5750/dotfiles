# WezTerm Configuration

Location: `config/wezterm/`

## Files

- `wezterm.lua` - Main configuration
- `keybindings.lua` - Key binding definitions (separated for maintainability)

## General Settings

- Auto-reload config: enabled
- Default key bindings: disabled (fully custom)
- Update check: daily (86400 seconds)
- Scrollback: 10,000 lines
- Bell: SystemBeep

## Font

- Primary: Hack Nerd Font (size 14)
- Fallback 1: JetBrainsMono Nerd Font
- Fallback 2: PlemolJP Console NF (Japanese support)
- IME: enabled (`use_ime = true`)

## Appearance

- Color scheme: Tokyo Night Storm
- Window opacity: 0.75
- macOS blur: 20pt
- Window decorations: RESIZE only (no title bar)
- Background gradient: solid black (#000000)
- Inactive pane: 70% saturation, 50% brightness
- Starts maximized via `gui-startup` event

## Tab Bar

- New tab button: hidden
- Custom tab title: shows directory name
- Active tab: gold (#ae8b2d), inactive: gray (#5c6d74)

## Key Bindings

All default bindings disabled; custom bindings defined in `keybindings.lua`:

| Key | Action |
|-----|--------|
| `CMD+q` | Quit |
| `CMD+c/v` | Copy/Paste |
| `CMD+k` | Clear scrollback |
| `CMD+t` | New tab (home dir) |
| `SHIFT+CMD+t` | New tab (current dir) |
| `CMD+w` | Close pane |
| `CMD+[/]` | Previous/Next tab |
| `CMD+d` | Split horizontal |
| `SHIFT+CMD+d` | Split vertical |
| `CTRL+8` | Pane select |
| `CTRL+SHIFT+Arrow` | Navigate panes |
| `CMD+=/-/0` | Font size adjust |
| `CMD+1-9` | Switch to tab N |
| `CMD+n` | New window (home dir) |
| `SHIFT+CMD+n` | New window |
