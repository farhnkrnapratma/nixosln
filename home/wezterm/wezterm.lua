local wezterm = require 'wezterm'

return {
  font = wezterm.font 'FiraCode Nerd Font Mono',
  font_size = 11,
  line_height = 1.2,
  default_cursor_style = 'BlinkingUnderline',
  window_decorations = 'NONE',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_background_opacity = 0.9,
  color_scheme = 'Catppuccin Macchiato',
  enable_tab_bar = false,
  keys = {
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = 'l',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    {
      key = 'h',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    {
      key = 'j',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    {
      key = 'k',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },

    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
  }
}
