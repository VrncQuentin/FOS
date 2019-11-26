    ;;  Receives sectors in dh & drive in dl
    [bits 16]
load_disk:
    pusha

    ;; Reading from disk requires specific values in all registers.
    ;; We'll overwrite our input parameters from dx so we save it in stack.
    push dx

    mov ah, 0x02                ; int 0x13, 0x02 = read
    mov al, dh                  ; Numbers of sector to read.
    mov cl, 0x02                ; Sector, 0x01 = bs, 0x02 = first available.
    mov ch, 0x00                ; Cylinder (0x0 .. 0x3FF, upper 2 bits in cl).
    ;;  dl = Drive number, set by caller & gets it from BIOS.
    ;;  (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00                ; Head number (0x0 .. 0xF)

    ;; [es:bx] = pointer to buffer where the data will be stored.
    ;; Caller sets it up for us & is actually the std locate for int 0x13
    int 0x13
    jc ld_error                 ; if carry bit (error)

    pop dx
    cmp al, dh                  ; BIOS also sets al to the # of sectors read, cmp.
    jne sector_error

    popa
    ret

ld_error:
    mov bx, DISK_ERR
    call puts16

    mov dh, ah                  ; ah = err code, dl = disk drive that dropped the err
    call print_hex16
    jmp $                       ; Hang & dies (maybe)

sector_error:
    mov bx, SECTOR_ERR
    call puts16


    ;; DATA
    DISK_ERR db "Disk read error.",0
    SECTOR_ERR db "Incorrect number of sectors read",0
