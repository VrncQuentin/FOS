    ;; Tells the assembler that we're bootsector & sets our offset in memory.
    [org 0x7c00]
    [bits 16]

    mov bp, 0x9000              ; Sets the stack.
    mov sp, bp

    mov bx, STR_REAL_MODE
    call puts16

    call switch_to_pm           ; We never return from here.

    ;; Include subroutines.
    %include "lib/asm/puts16.asm"
    %include "lib/asm/putspm.asm"
    %include "bs/gdt.asm"
    %include "bs/switch_pm.asm"

    [bits 32]
    ;; This is where we land after pm switch & init.
begin_pm:
    mov ebx, STR_PROT_MODE
    call puts_pm

    jmp $                      ; Hang

    ;; DATA
    STR_REAL_MODE db "Started in 16-bit Real Mode",0
    STR_PROT_MODE db "Successfully landed in 32-bit Protected Mode",0

    ;; Padding & Magic BIOS Number.
    times 510-($-$$) db 0
    dw 0xaa55
