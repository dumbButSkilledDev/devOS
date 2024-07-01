#include <graphics/textmode.h>
#include <ver.h>
#include <init.h>

extern void cause_havoc();

void kernel_entry()
{
    vram_text_init();
    print("DevKernel loaded!\n");
    print("DevKernel Version: 0.1\n");
    print("[Kernel] Handing off control to kernel init!\n");
    kinit();
    print("[Kernel] Testing IDT....\n");
    cause_havoc();
    print("[Kernel] A error should of been thrown!\n");
}
