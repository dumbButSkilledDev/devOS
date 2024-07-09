#include <init.h>

void kinit() {
    print("[INIT] initalizing IDT...\n");
    load_idt();
    print("[INIT] initalizing PIC...\n");
    
    print("[INIT] Handing off control to kernel...\n");
}