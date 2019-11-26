    ;; Tells the assembler that we're bootsector & sets our offset in memory.
    [org 0x7c00]

    mov [BOOT_DRIVE], dl        ; BIOS stores our boot drive in dl.

    mov bp, 0x9000              ; Sets the stack.
    mov sp, bp

    mov bx, STR_REAL_MODE
    call puts16

    call load_kernel
    call switch_to_pm           ; We never return from here.

    ;; Include subroutines.
    %include "lib/asm/puts16.asm"
    %include "lib/asm/putspm.asm"
    %include "lib/asm/print_hex.asm"
    %include "lib/asm/load_disk.asm"
    %include "bs/gdt.asm"
    %include "bs/switch_pm.asm"

    [bits 16]
load_kernel:
    mov bx, STR_LD_KERNEL
    call puts16

    ;; Sets parameters for load_disk, so that we load the first 15 sectors,
    ;; excluding boot sector, from the boot disk (i.e. our kernel code )
    ;; to the adresse KERNEL_OFFSET
    mov bx, KERNEL_OFFSET
    mov dh, 2                   ; Magic value, we could load more to be certain.
    mov dl, [BOOT_DRIVE]
    call load_disk

    ret

    [bits 32]
    ;; This is where we land after pm switch & init.
begin_pm:
    mov ebx, STR_PROT_MODE
    call puts_pm

    call KERNEL_OFFSET          ; Jump to where we loaded our Kernel.

    jmp $                       ; Hang

    ;; DATA
KERNEL_OFFSET:  equ 0x1000    ; Memory offset to which we'll load our kernel.
BOOT_DRIVE:     db 0          ; Disk number.

STR_REAL_MODE:  db "Started in 16-bit Real Mode.",0
STR_LD_KERNEL:  db "Loading Kernel.",0
STR_PROT_MODE:  db "Successfully landed in 32-bit Protected Mode.",0

    ;; Padding & Magic BIOS Number.
    times 510-($-$$) db 0
    dw 0xaa55
