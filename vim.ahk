#Requires AutoHotkey v2.0

#HotIf WinActive("ahk_class mintty")
CapsLock:: {
    Send("{Ctrl down}")
    KeyWait("CapsLock")
    Send("{Ctrl up}")
}
#HotIf

#HotIf WinActive("ahk_class Emacs")
CapsLock:: {
    Send("{Ctrl down}")
    KeyWait("CapsLock")
    Send("{Ctrl up}")
}
#HotIf

#HotIf WinActive("ahk_exe WindowsTerminal.exe")
CapsLock:: {
    Send("{Ctrl down}")
    KeyWait("CapsLock")
    Send("{Ctrl up}")
}
#HotIf
