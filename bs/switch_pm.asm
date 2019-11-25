    [bits 16]
    ;; Switch 32bits to Protected Mode.
switch_to_pm:
    cli                         ; Tell the CPU to ignore Interrupts for now.
    lgdt [gdt_descriptor]       ; Tell the CPU about our GDT.

    ;; cr0 is a control register, we can't use litterals to set it.
    mov eax, cr0                ; Get cr0.
    or eax, 0x1                 ; Sets the 1st bit
    mov cr0, eax                ; Update cr0 & Do the switch.

    ;; Far jump (eg: to a new segment) to our 32bits code.
    ;; This forces the CPU to flush its cache (of pre-fetched & 16bits real-mode
    ;; decoded instructions, which can cause problems.
    jmp CODE_SEG:init_pm

    [bits 32]
init_pm:
    mov ax, DATA_SEG            ; Makes ax point to our data segment.
    mov ds, ax                  ; Sets all segment register to the data
    mov ss, ax                  ; segment defined in our GDT.
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000            ; Update our stack position so it's right
    mov esp, ebp                ; at the top of the free space.

    call begin_pm
