    ;; Recieves data in 'dx' (data is an hexa number in the form 0x0000)
    [bits 16]
print_hex16:
    pusha                       ; push all register into stack.
    mov cx, 0                   ; index variable.

prep_string:
    cmp cx, 4                   ; Loop 4 times.
    je phexa_done

    ;;  Convert last char of 'dx' to ASCII.
    mov ax, dx                  ; 'ax' will be our working register.
    and ax, 0x000f              ; Masking first three bytes to 0. eg: 0x1234 -> 0x0004

    add al, 0x30                ; add '0' to N to convert it to ASCII 'N'.
    cmp al, 0x39                ; if > '9', add extra 8 to represent 'A' to 'F'.
    jle put_in_string           ; if <= '9'.
    add al, 7                   ; 0 -> 7 = 8.

put_in_string:
    mov bx, hexa_str + 5        ; base + length.
    sub bx, cx                  ; Index of our char.
    mov [bx], al                ; Copy the char to the index pointer by 'bx'.

    ;; Continue loop.
    ror dx, 4                   ; Rotate Right our data. 0x1234 -> 0x4123 -> 0x3412 -> ...
    add cx, 1
    jmp prep_string

phexa_done:
    mov bx, hexa_str
    call puts16

    popa                        ; returns all register from stack.
    ret

    ;; Data.
hexa_str:
    db "0x0000",0               ; Reserve memory for our string
