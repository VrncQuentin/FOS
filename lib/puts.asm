    ;;  Recieves data in 'bx'
puts:
    pusha
    mov ah, 0x0e                ; Scrolling teletype BIOS routine.

puts_loop:
    mov al, [bx]                ; stores current index of bx in al.
    cmp al, 0                   ; checks if end of string.
    je puts_done                ; exit if true
    int 0x10                    ; print interrupt

    add bx, 1                   ; move index to next char
    jmp puts_loop               ; re-do

puts_done:
    mov al, 0x0a                ; puts '\n' in al
    int 0x10
    mov al, 0x0d                ; puts '\r' in al
    int 0x10

    popa
    ret
