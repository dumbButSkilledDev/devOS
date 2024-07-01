Hey there!

the entry point (when the boot loader is launched) is in src/stage1/boot.asm!
the fun part (protected mode (step 2)) is in src/stage2/32/entry32.asm! (for loading the kernel and long mode impl (TODO) look here!)

ENTRY32.asm is infact part of the code because of how includes work! thats our 32 bit entry!
