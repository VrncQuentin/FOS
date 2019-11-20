    ;;  Recieves data in 'bx'
puts:
    pusha
    mov ah, 0x0e                ; Scrolling teletype BIOS routine.
    jmp loop

loop:
    mov al, [bx]                ; stores current index of bx in al.
    cmp al, 0                   ; checks if end of string.
    je done                     ; exit if true
    int 0x10                    ; print interrupt

    add bx, 1                   ; move index to next char
    jmp loop                    ; re-do

done:
    mov al, 0x0a                ; puts '\n' in al
    int 0x10
    popa
    ret
