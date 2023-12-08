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
        ; 这里发送 ctrl up 的目的是防止出现 ^esc 组合键出现 LWin 的效果, 这里必须是 blind, 不然会导致 win 的出现
        Send("{Blind}{Ctrl Up}")
        Send("{esc}")
    } 
    if GetKeyState("ctrl") {
        Send("{Blind}{Ctrl Up}")
    }
}