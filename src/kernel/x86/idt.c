#include <x86/drivers/idt.h>

struct idt_descriptor descriptors[DEVOS_TOTAL_INTERUPTS];
struct idtr_descriptor idtr_desc;

extern void idt_load(void *ptr);

void idt_zero_err() {
    kernel_panic("You can not divide by zero.", "BRO_TRIED_TO_DIV_BY_ZERO");
    while (1) {}
}

void idt_set(int i_no, void *addr) {
    struct idt_descriptor* desc = &descriptors[i_no];
    desc->offset_1 = (uint32_t)addr & 0x0000ffff;
    desc->selector = KERNEL_CODE_OFFSET;
    desc->zero = 0x00;
    desc->type_attr = 0xEE;
    desc->offset_2 = (uint32_t)addr >> 16;
}

void init_idt() {
    memset(descriptors, 0, sizeof(descriptors));
    idtr_desc.limit = sizeof(descriptors) - 1;
    idtr_desc.base = (uint32_t)descriptors;
    idt_set(0, idt_zero_err);
    idt_load(&idtr_desc);
}

void load_idt() {
    init_idt(); // lol
}
