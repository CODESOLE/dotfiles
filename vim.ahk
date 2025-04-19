#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class Vim")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_class ConsoleWindowClass")
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

#HotIf WinActive("ahk_exe Code.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe emacs.exe")
CapsLock::Ctrl
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe zen.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe msedge.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe VSCodium.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.

#HotIf WinActive("ahk_exe neovide.exe")
CapsLock::Esc
#HotIf  ; This puts subsequent remappings and hotkeys in effect for all windows.
