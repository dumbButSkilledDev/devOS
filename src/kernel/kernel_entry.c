#include <graphics/textmode.h>
#include <ver.h>
#include <init.h>
#include <x86/hardware/io.h>

extern void cause_havoc();

void kernel_entry()
{
    vram_text_init();
    print("DevKernel loaded!\n");
    print("DevKernel Version: 0.1\n");
    print("[Kernel] Handing off control to kernel init!\n");
    kinit();
    print("[Kernel] KINFO: legacy/multiboot compliant kernel\n");
}
