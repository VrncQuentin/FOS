    ;; Tells the assembler that we're bootsector & sets our offset in memory.
    [org 0x7c00]

    ;; A simple  boot  sector  program.
    mov bx, start
    call puts

    mov bx, off
    call puts

    jmp $

    ;; Include subroutines.
    %include "lib/puts.asm"

    ;; DATA
start:
    db 'Booting OS',0

off:
    db 'Good Bye',0

    ;; Padding & Magic BIOS Number.
    times 510-($-$$) db 0
    dw 0xaa55
