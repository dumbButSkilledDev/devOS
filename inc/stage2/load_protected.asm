switch_to_protected:
    call .load_gdt
    jmp .load_protected

    .load_gdt:
        cli ; clear interupts
        lgdt[gdt_descriptor] ; load gdt
        ret
    .load_protected:
        mov si, msg_pmf
        call print_str
        mov eax, cr0
        or eax, 0x1
        mov cr0, eax
        jmp CODE_SEG:load32
        mov si, dl_succ
        call print_str
        jmp $
