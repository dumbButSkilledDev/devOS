ORG 0x7c00
BITS 16


CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
_start:
    jmp short stage1_entry
    nop

  times 33 db 0

stage1_entry:
    jmp 0:stage1

stage1:
    cli
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp
    mov sp, 0x7c00

    sti ; sexually transmitteid infec.. i mean enable interupts

    call switch_to_protected ; 32 bit time

%include "inc/stage1/io.asm"
%include "inc/stage1/msgencoder.asm"
%include "inc/stage2/gdt.asm"
%include "inc/stage2/load_protected.asm" 

[BITS 32]
load32:
    jmp entry32
    hlt

%include "src/stage2/32/entry32.asm"
%include "inc/stage2/32/lba.asm"

times 510-($ - $$) db 0
dw 0xAA55
