local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.colors = {
  foreground = '#bdbdbd',
  background = '#080808',
  cursor_bg = '#9e9e9e',
  cursor_fg = '#080808',
  cursor_border = '#080808',
  selection_fg = '#080808',
  selection_bg = '#b2ceee',
}

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'Developer Command Prompt',
    args = { 'cmd.exe', '/k', 'C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvars64.bat' },
  })
end

config.launch_menu = launch_menu
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font 'Cascadia Mono'
config.window_decorations = 'TITLE|RESIZE'
config.use_resize_increments = true
config.font_size = 10
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.use_fancy_tab_bar = false
config.keys = {}
for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config
