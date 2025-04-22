; === AutoHotkey v2 Script ===
; Purpose: Map Caps Lock to Left Control ONLY when Emacs, Mintty, or Windows Terminal
;          is the active window. Otherwise, Caps Lock behaves normally.
; Fix: Addresses potential "stuck Ctrl" issue when switching windows.

#Requires AutoHotkey v2.0

; --- Global flag to track if CapsLock was pressed down while a target app was active ---
global _ctrlRemapActive := false

; --- Helper Function to check if the active window belongs to a target app ---
IsTargetAppActive() {
    ; Add or remove executable names from this list as needed
    Return WinActive("ahk_exe emacs.exe")
        || WinActive("ahk_exe mintty.exe")
        || WinActive("ahk_exe WindowsTerminal.exe")
}

; --- Conditional Down Action ---
; Use the * prefix so it fires even if other modifiers are held.
#HotIf IsTargetAppActive() ; Use the helper function for the condition
    *CapsLock::
    {
        ; When CapsLock is pressed DOWN in a target app:
        Send("{LCtrl Down}")      ; Send the Control key DOWN event
        global _ctrlRemapActive := true ; Set the flag
        Return                    ; Block the native CapsLock DOWN function
    }
#HotIf ; End the conditional block

; --- Unconditional Up Action ---
; This handles the CapsLock UP event REGARDLESS of the currently active window.
; Use the * prefix so it fires even if other modifiers are held.
*CapsLock Up::
{
    ; Check if the flag is true (meaning the DOWN press happened in a target app)
    if (_ctrlRemapActive)
    {
        Send("{LCtrl Up}")          ; Send the corresponding Control key UP event
        global _ctrlRemapActive := false ; Reset the flag
    }
    else
    {
        ; If the flag is false, the DOWN press happened outside a target app.
        ; Manually toggle the CapsLock state to replicate normal behavior.
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
    Return ; Generally good practice for Up handlers like this
}

; === End of Script ===

; --- How it Works ---
; 1. Helper Function `IsTargetAppActive()`: Checks if the active window's executable
;    is emacs.exe, mintty.exe, OR WindowsTerminal.exe. Returns true if any match.
; 2. Flag `_ctrlRemapActive`: Tracks if CapsLock was pressed while one of the
;    target apps was active.
; 3. CapsLock Down (In Target App): If `IsTargetAppActive()` is true, pressing
;    CapsLock sends LCtrl Down and sets the flag.
; 4. CapsLock Down (Outside Target App): The conditional hotkey doesn't fire.
;    Default OS CapsLock behavior occurs for the down press.
; 5. CapsLock Up (Any Window): Always triggers.
;    - If the flag is true: Sends LCtrl Up and clears the flag.
;    - If the flag is false: Toggles the actual CapsLock state.

; --- How to Use ---
; 1. Ensure AutoHotkey v2 is installed.
; 2. Save this code (e.g., `multi_app_capslock_conditional.ahk`).
; 3. Close any previous versions of the script (check system tray).
; 4. Run the new script.
; 5. Test:
;    - Open Emacs, Mintty, or Windows Terminal. CapsLock should act as Ctrl.
;    - Switch to Notepad or another app. CapsLock should toggle capitalization.
;    - Hold CapsLock in Emacs/Mintty/WT, Alt+Tab away, release CapsLock. Ctrl should not get stuck.
