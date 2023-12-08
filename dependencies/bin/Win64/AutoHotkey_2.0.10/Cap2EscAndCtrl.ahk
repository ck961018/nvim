*CapsLock:: {
    if A_PriorKey = "LControl" {
        SendInput("{blind}{sc0x0EA}")
    }
    if !GetKeyState("ctrl") {
        Send("{Blind}{Ctrl Down}")
    }
}

*CapsLock up:: {
    Send("{Blind}{Ctrl Up}")
    if A_PriorKey = "CapsLock" {
        Send("{esc}")
    }
}