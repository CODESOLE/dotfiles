#Requires AutoHotkey v2.0

; --- Configuration ---

; Add the EXACT executable names (case-insensitive) of the programs
; where you want this CapsLock behavior to apply.
; Find names using Task Manager -> Details tab.
global TargetExecutables := ["mdedge.exe", "emacs.exe", "mintty.exe"]

TapTimeout := 0.2 ; Seconds to wait before considering it a 'hold'. Adjust as needed.

; --- Helper Function ---

; Checks if the currently active window belongs to one of the target executables
IsTargetWindowActive() {
    global TargetExecutables ; Access the global list
    CurrentExe := WinGetProcessName("A") ; Get the exe name of the Active window
    if !CurrentExe ; If no active window or couldn't get name, return false
        return false

    ; Loop through the list of target executables
    for exeName in TargetExecutables {
        ; Compare case-insensitively
        if (StrLower(CurrentExe) = StrLower(exeName)) {
            return true ; Found a match, return true
        }
    }
    return false ; No match found after checking all targets
}


; --- Script Logic ---

; Global flag to track if CapsLock is currently acting as Ctrl
; This needs to be global because its state persists across key presses
global IsCapsLockActingAsCtrl := false

; --- Hotkeys active ONLY in target applications ---
#HotIf IsTargetWindowActive() ; Apply the condition

    ; Ensure CapsLock's toggle state doesn't interfere WITHIN target apps
    ; Doing it here makes it context-sensitive too
    SetCapsLockState "AlwaysOff"

    ; Hotkey when CapsLock is pressed DOWN
    *CapsLock:: {
        global IsCapsLockActingAsCtrl ; Make flag accessible
        local released_in_time

        released_in_time := KeyWait("CapsLock", "P T" . TapTimeout)

        if (released_in_time) {
            ; --- TAP ---
            if (!GetKeyState("Control", "P") && !GetKeyState("Shift", "P") && !GetKeyState("Alt", "P") && !GetKeyState("LWin", "P") && !GetKeyState("RWin", "P")) {
                SendInput("{Escape}")
            }
        }
        else {
            ; --- HOLD ---
            SendInput("{LCtrl Down}")
            IsCapsLockActingAsCtrl := true
        }
    }

    ; Hotkey when CapsLock is released UP
    CapsLock Up:: {
        global IsCapsLockActingAsCtrl ; Make flag accessible

        if (IsCapsLockActingAsCtrl) {
            SendInput("{LCtrl Up}")
            IsCapsLockActingAsCtrl := false
        }
    }

#HotIf ; Turn off context sensitivity for any hotkeys below this line

; --- End of Script ---

; Optional: If you want Caps Lock to behave completely normally outside
; the target apps (including toggling the light/state), you could add:
#HotIf !IsTargetWindowActive() ; Apply when NOT in target apps
    *CapsLock:: Send "{Blind}{CapsLock}" ; Pass the key through normally
#HotIf
; Note: The SetCapsLockState "AlwaysOff" within the target #HotIf block might
; still cause the light to stay off system-wide. If you strictly need the
; light to work normally outside target apps, avoid SetCapsLockState altogether
; and accept the Caps Lock state might briefly toggle during a hold.
; For most users, keeping SetCapsLockState where it is (inside the target #HotIf)
; is the simplest approach if you don't mind the light being off.
