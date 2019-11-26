    [bits 32]

    ;; DATA
    VIDEO_MEM equ 0xb8000
    WOB equ 0x0f                ; White on Black.

    ;; Receives data in ebx
puts_pm:
    pusha
    mov edx, VIDEO_MEM          ; Set edx to the start of video memory.
    mov ah, WOB                 ; Store the attributes in ah.

ppm_loop:
    mov al, [ebx]
    cmp al, 0
    je ppm_done
    mov [edx], ax               ; Store char & attr to current char cell.

    add ebx, 1                  ; Next char in ebx.
    add edx, 2                  ; Next char cell in vid mem.
    jmp ppm_loop

ppm_done:
    popa
    ret
