#Requires AutoHotkey v2.0

; alttab_blocker.ahk
; Blocks Alt+Tab and related task switching shortcuts
#SingleInstance Force

global altTabBlocked := false

ToggleAltTabBlock(*) {
    global altTabBlocked
    if altTabBlocked
        DisableAltTabBlock()
    else
        EnableAltTabBlock()
}

EnableAltTabBlock() {
    global altTabBlocked

    ; Block Alt+Tab variants
    Hotkey("!Tab", BlockKey, "On")
    Hotkey("!+Tab", BlockKey, "On")

    ; Block Win+Tab (Task View)
    Hotkey("#Tab", BlockKey, "On")

    ; Block Ctrl+Alt+Tab (persistent task switcher)
    Hotkey("^!Tab", BlockKey, "On")

    altTabBlocked := true

    ; Show notification
    ToolTip("Alt+Tab blocking enabled")
    SetTimer(() => ToolTip(), -2000)
}

DisableAltTabBlock() {
    global altTabBlocked

    ; Unblock all shortcuts
    Hotkey("!Tab", "Off")
    Hotkey("!+Tab", "Off")
    Hotkey("#Tab", "Off")
    Hotkey("^!Tab", "Off")

    altTabBlocked := false

    ; Show notification
    ToolTip("Alt+Tab blocking disabled")
    SetTimer(() => ToolTip(), -2000)
}

BlockKey(*) {
    ; Do nothing - this blocks the key
    return
}

; Hotkey to toggle Alt+Tab blocking
Hotkey("^+'", ToggleAltTabBlock)

; Cleanup on exit
OnExit((*) => (altTabBlocked && DisableAltTabBlock()))