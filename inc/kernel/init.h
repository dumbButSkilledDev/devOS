#pragma once
#include <graphics/textmode.h>
#include <x86/drivers/idt.h>

void kinit() {
    print("[INIT] loading IDT...\n");
    load_idt();
    print("[INIT] Complete...\n");
}
