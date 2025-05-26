local wezterm = require "wezterm"

return {
  font = wezterm.font 'FiraCode Nerd Font',
  font_size = 11,
  line_height = 1.2,
  window_background_opacity = 0.7,
  color_scheme = 'Catppuccin Latte',
  enable_tab_bar = false,
  keys = {
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.ToggleFullScreen,
    },
}
}
