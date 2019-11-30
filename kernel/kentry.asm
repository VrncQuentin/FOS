    ;; Allows us to make sure we properly enter Kernel.
    [bits 32]
    [extern kmain]

    call kmain
