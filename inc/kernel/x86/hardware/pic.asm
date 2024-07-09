remap_pic:
        mov al, 00010001b
        out 0x20, al
        mov al, 0x20
        out 0x21, al

        mov al, 00000001b
        out 0x21, al