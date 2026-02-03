#Requires AutoHotkey v2.0
#SingleInstance Force

; Solicita privilégios de administrador
if !A_IsAdmin {
    Run('*RunAs "' A_ScriptFullPath '"')
    ExitApp()
}

global toggle := false

; O script só processa os comandos abaixo se a janela do jogo estiver ativa
#HotIf WinActive("ahk_exe 7DaysToDie.exe")

~$w:: {
    global toggle
    static last_press := 0
    current_time := A_TickCount
    
    ; Se já estiver travado, o próximo toque no W solta a tecla
    if (toggle) {
        toggle := false
        Send("{w up}")
        return
    }
    
    ; Verifica clique duplo com seu intervalo personalizado de 900ms
    if (current_time - last_press < 300) {
        toggle := true
        Sleep(200) ; Seu delay de estabilidade testado
        Send("{w down}")
        last_press := 0
    } else {
        last_press := current_time
    }
}

; Opcional: Pressionar S desativa a trava para evitar conflitos de movimento
~s:: {
    global toggle := false
    Send("{w up}")
}

#HotIf

