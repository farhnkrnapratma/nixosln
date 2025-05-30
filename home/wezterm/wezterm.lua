local wezterm = require "wezterm"

return {
  font = wezterm.font 'FiraCode Nerd Font',
  font_size = 11,
  line_height = 1.2,
  window_decorations = "NONE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_background_opacity = 0.6,
  color_scheme = 'Catppuccin Macchiato',
  enable_tab_bar = false,
  keys = {
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.ToggleFullScreen,
    },
}
}
