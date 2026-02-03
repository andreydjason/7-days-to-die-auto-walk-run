#Requires AutoHotkey v2.0
#SingleInstance Force

if !A_IsAdmin {
    Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp()
}

global toggle := false

#HotIf WinActive("ahk_exe 7DaysToDie.exe")

~$w:: {
    global toggle
    static last_press := 0
    
    ; Espera você soltar o W antes de prosseguir, impedindo o loop de "tecla segurada"
    KeyWait("w")
    
    current_time := A_TickCount
    
    if (toggle) {
        toggle := false
        Send("{w up}")
        return
    }
    
    if (current_time - last_press < 900) {
        toggle := true
        Sleep(200)
        Send("{w down}")
        last_press := 0
    } else {
        last_press := current_time
    }
}

~s:: {
    global toggle := false
    Send("{w up}")
}

#HotIf
