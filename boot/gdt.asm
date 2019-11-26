    ;; Global Descriptor Table
gdt_start:

gdt_null:                       ; Mandatory NULL descriptor.
    dd 0x0                      ; 'dd' == define double (word, i.e: 4Bytes)
    dd 0x0                      ; We zero-ed the 8 first byte as required.

gdt_code:                       ; Code segment descriptor.
    dw 0xffff                   ; Limit (bits 0-15)
    dw 0x0                      ; Base (bits 0-15)
    db 0x0                      ; Base (bits 16-23)
    db 10011010b                ; type flags (8 bits)
    db 11001111b                ; limit flags (4 bits) + segment length, bits 16-19
    db 0x0                      ; segment base, bits 24-31

; GDT for data segment. base and length identical to code segment
; some flags changed, again, refer to os-dev.pdf
gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size (16 bit), always one less of its true size
    dd gdt_start ; address (32 bit)

; define some constants for later use
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
