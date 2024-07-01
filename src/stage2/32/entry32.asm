entry32:
    ; load kernel (kernel _start address)
    mov eax, 1
    mov ecx, 100
    mov edi, 0x0100000
    call ata_lba_read ; read kernel
    jmp CODE_SEG:0x0100000 ; goto kernel

