local wezterm = require 'wezterm'
local act = wezterm.action

-- ============================================================================
-- KEY BINDINGS
-- ============================================================================

local keybindings = {}

-- Basic terminal operations
keybindings.keys = {
  -- General
  { key = 'q', mods = 'CMD', action = act.QuitApplication },

  -- Copy/Paste
  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },

  -- Tab management
  { key = 't', mods = 'CMD', action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }) },
  { key = 't', mods = 'SHIFT|CMD', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w', mods = 'CMD', action = act.CloseCurrentPane({ confirm = false }) },

  -- Tab navigation
  { key = '[', mods = 'CMD', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'CMD', action = act.ActivateTabRelative(1) },

  -- Pane management
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'SHIFT|CMD', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '8', mods = 'CTRL', action = act.PaneSelect },

  -- Font size adjustment
  { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = act.ResetFontSize },

  -- Tab switching by number
  { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = act.ActivateTab(8) },

  -- Window management
  { key = 'n', mods = 'CMD', action = act.SpawnCommandInNewWindow({ cwd = wezterm.home_dir }) },
  { key = 'n', mods = 'SHIFT|CMD', action = act.SpawnWindow },
}

return keybindings
