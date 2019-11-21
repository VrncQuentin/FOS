    ;; Tells the assembler that we're bootsector & sets our offset in memory.
    [org 0x7c00]

    ;; A simple  boot  sector  program that tests my print func.
    mov bx, bs_start
    call puts

    mov bx, bs_off
    call puts

    mov dx, 0x1234
    call print_hex

    mov dx, 0x12
    call print_hex

    jmp $

    ;; Include subroutines.
    %include "lib/puts.asm"
    %include "lib/print_hex.asm"

    ;; DATA
bs_start:
    db 'Booting OS',0

bs_off:
    db 'Good Bye',0

    ;; Padding & Magic BIOS Number.
    times 510-($-$$) db 0
    dw 0xaa55
