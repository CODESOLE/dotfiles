#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class Vim")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe alacritty.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_class org.wezfurlong.wezterm")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.
