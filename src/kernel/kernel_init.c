#include <init.h>

extern void idtCheckDZ();

void kinit() {
    print("[INIT] initalizing IDT...\n");
    load_idt();
    print("[IDT] IDT loaded!\n");
    print("[IDT] Checking interrupts...\n");
    idtCheckDZ();
    idtMsg = "[LOGIC] You cant divide by zero!\n"; // reset divide by zero message
    print("[INIT] initalizing PIC...\n");

    print("[INIT] Handing off control to kernel...\n");
}