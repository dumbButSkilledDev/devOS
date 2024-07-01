print_str:
    mov bx, 0
   .loop:
       lodsb
       cmp al, 0
       je .done
       call print_ch
       jmp .loop
   .done:
       ret

print_ch:
    mov ah, 0eh
    int 0x10
    ret
