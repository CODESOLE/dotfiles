; === AutoHotkey v2 Script ===
; Purpose: Map Caps Lock to Left Control ONLY when Emacs is the active window.
;          Otherwise, Caps Lock behaves as the standard Caps Lock key.
; Fix: Addresses potential "stuck Ctrl" issue when switching windows.

#Requires AutoHotkey v2.0

; --- Global flag to track if CapsLock was pressed down while Emacs was active ---
global _capsLockWasDownInEmacs := false

; --- Conditional Down Action ---
; Use the * prefix so it fires even if other modifiers are held.
#HotIf WinActive("ahk_exe emacs.exe")
    *CapsLock::
    {
        ; When CapsLock is pressed DOWN in Emacs:
        Send("{LCtrl Down}")      ; Send the Control key DOWN event
        global _capsLockWasDownInEmacs := true ; Set the flag
        Return                    ; Block the native CapsLock DOWN function
    }
#HotIf

; --- Unconditional Up Action ---
; This handles the CapsLock UP event REGARDLESS of the currently active window.
; Use the * prefix so it fires even if other modifiers are held.
*CapsLock Up::
{
    ; Check if the flag is true (meaning the DOWN press happened in Emacs)
    if (_capsLockWasDownInEmacs)
    {
        Send("{LCtrl Up}")          ; Send the corresponding Control key UP event
        global _capsLockWasDownInEmacs := false ; Reset the flag
    }
    else
    {
        ; If the flag is false, the DOWN press happened outside Emacs.
        ; Since this hotkey definition overrides the default OS behavior
        ; for CapsLock Up, we need to manually toggle the state here
        ; to replicate the normal Caps Lock behavior.
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
    Return ; Generally good practice for Up handlers like this
}

; === End of Script ===

; --- How it Works ---
; 1. Flag Initialization: A variable `_capsLockWasDownInEmacs` is created and set to `false`.
; 2. CapsLock Down (In Emacs):
;    - The `#HotIf WinActive...` checks if Emacs is active.
;    - If yes, the `*CapsLock::` hotkey triggers when CapsLock is pressed down.
;    - It sends `LCtrl Down` to the system.
;    - It sets the `_capsLockWasDownInEmacs` flag to `true`.
;    - `Return` prevents the normal CapsLock action.
; 3. CapsLock Down (Outside Emacs):
;    - The `#HotIf` condition is false.
;    - The `*CapsLock::` hotkey inside the `#HotIf` block does NOT trigger.
;    - The default OS behavior for CapsLock Down occurs (preparing to toggle state).
; 4. CapsLock Up (Any Window):
;    - The `*CapsLock Up::` hotkey triggers *unconditionally* when CapsLock is released.
;    - It checks the `_capsLockWasDownInEmacs` flag:
;      - If `true`: It means the corresponding DOWN press was in Emacs and sent `LCtrl Down`. So, this UP handler sends `LCtrl Up` and resets the flag to `false`.
;      - If `false`: It means the DOWN press happened outside Emacs. To mimic default behavior (which this hotkey now overrides), it manually toggles the CapsLock state using `SetCapsLockState !GetKeyState("CapsLock", "T")`.
; 5. `Return` in the `Up` handler ensures no other unintended actions occur.

; --- How to Use ---
; 1. Make sure you have AutoHotkey v2 installed.
; 2. Save this code, replacing the previous version (e.g., `emacs_capslock_conditional_fixed.ahk`).
; 3. Close the old script (right-click -> Exit on the tray icon).
; 4. Run the new script.
; 5. Test the switching scenario: Hold CapsLock in Emacs, Alt+Tab to another window, then release CapsLock. The Ctrl key should now release correctly. Then test normal CapsLock function outside Emacs.
