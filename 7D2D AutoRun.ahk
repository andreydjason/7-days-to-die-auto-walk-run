#Requires AutoHotkey v2.0
#SingleInstance Force

if !A_IsAdmin {
    Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp()
}

global toggle := false

#HotIf WinActive("ahk_exe 7DaysToDie.exe")

; '*' permite que a aspa funcione mesmo se o W estiver pressionado
*$':: {
    global toggle
    if (toggle) {
        toggle := false
        Send("{w up}")
    } else {
        toggle := true
        ; Se já estiver segurando W, o Sleep garante a transição para a trava
        Sleep(200)
        Send("{w down}")
    }
}

~$w:: {
    global toggle
    static last_press := 0
    
    ; Se a trava já estiver ligada, soltar o W físico ou clicar de novo desliga
    if (toggle) {
        toggle := false
        Send("{w up}")
        return
    }
    
    KeyWait("w")
    current_time := A_TickCount
    
    if (current_time - last_press < 300) {
        toggle := true
        Sleep(100)
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
