#Requires AutoHotkey v2.0
#SingleInstance Force

if !A_IsAdmin {
    Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp()
}

global toggle := false

#HotIf WinActive("ahk_exe 7DaysToDie.exe")

; Lógica da Aspa Simples (') - Alterna a trava com um toque
$':: {
    global toggle
    if (toggle) {
        toggle := false
        Send("{w up}")
    } else {
        toggle := true
        Sleep(100)
        Send("{w down}")
    }
}

; Lógica do W - Mantém o clique duplo (300ms)
~$w:: {
    global toggle
    static last_press := 0
    
    KeyWait("w")
    current_time := A_TickCount
    
    if (toggle) {
        toggle := false
        Send("{w up}")
        return
    }
    
    if (current_time - last_press < 300) {
        toggle := true
        Sleep(200)
        Send("{w down}")
        last_press := 0
    } else {
        last_press := current_time
    }
}

; Destrava ao apertar S (ré)
~s:: {
    global toggle := false
    Send("{w up}")
}

#HotIf
