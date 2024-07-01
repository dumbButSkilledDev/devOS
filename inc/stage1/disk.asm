disk_read:
    mov ah, 2 ; read sector interupt arg
    mov al, 1 ; amount of sectors to read
    mov ch, 0 ; low 8 bits
    mov cl, 2 ; read sec 2
    mov dh, 0 ; head
    mov bx, buffer ; buffer set
    int 0x13
    jc .error
    jmp .complete
.error:
    mov si, disk_error_read
    call print_str
    jmp $
.complete:
    mov si, dl_succ
    call print_str
    ret
