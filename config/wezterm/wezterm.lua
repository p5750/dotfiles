local wezterm = require 'wezterm'
local keybindings = require 'keybindings'
local config = wezterm.config_builder()

-- ============================================================================
-- GENERAL SETTINGS
-- ============================================================================
config.automatically_reload_config = true
config.disable_default_key_bindings = true
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400
config.scrollback_lines = 10000
config.audible_bell = "SystemBeep"

-- ============================================================================
-- KEY BINDINGS
-- ============================================================================
config.keys = keybindings.keys

-- ============================================================================
-- FONT CONFIGURATION
-- ============================================================================
config.font_size = 14.0
config.font = wezterm.font_with_fallback {
  'Hack Nerd Font',
  'JetBrainsMono Nerd Font',
  'PlemolJP Console NF',
}

-- ============================================================================
-- INPUT METHOD CONFIGURATION
-- ============================================================================
config.use_ime = true

-- ============================================================================
-- WINDOW APPEARANCE
-- ============================================================================
-- Window transparency and blur effects
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20

-- Window decorations and frame
config.window_decorations = "RESIZE"
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}

-- Window background styling
config.window_background_gradient = {
  colors = { "#000000" },
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.5,
}

-- Window Maximize
wezterm.on("gui-startup", function()
  local _, _, window = wezterm.mux.spawn_window({})
  window:gui_window():maximize()
end)

-- ============================================================================
-- COLOR SCHEME
-- ============================================================================
config.color_scheme = "Tokyo Night Storm"
config.char_select_bg_color = "#282A36"
config.char_select_fg_color = "#F8F8F2"

-- ============================================================================
-- TAB BAR CONFIGURATION
-- ============================================================================
-- Tab bar appearance
config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  }
}

-- Custom tab title formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#5c6d74"
  local foreground = "#FFFFFF"

  if tab.is_active then
    background = "#ae8b2d"
    foreground = "#FFFFFF"
  end

  local cwd = tab.active_pane.current_working_dir
  local dir_name = cwd and cwd.file_path:match("([^/]+)/?$") or "~"
  local title = "   " .. dir_name .. "   "

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

return config
