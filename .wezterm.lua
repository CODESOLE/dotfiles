local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
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
  config.default_prog = { 'powershell.exe', '-NoLogo' }
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })
  for _, vsvers in ipairs(wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')) do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
        .. vsvers
        .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
end

config.launch_menu = launch_menu
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.font_size = 9
config.adjust_window_size_when_changing_font_size = true
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
return config
