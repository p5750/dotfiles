# Hammerspoon Configuration

Location: `config/hammerspoon/`

## Files

- `init.lua` - Main configuration
- `Spoons/` - Directory for Spoons (currently empty, gitignored)

## Setup

Hammerspoon config path is set via macOS defaults in `scripts/setup-mac.bash`:

```
defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
```

## Keybindings

| Key | Action |
|-----|--------|
| `CTRL+I` | Toggle WezTerm window (launch/focus or hide) |

This is the only keybinding. It provides quick terminal access from any application.
