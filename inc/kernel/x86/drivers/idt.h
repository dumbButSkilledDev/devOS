#pragma once
#include <stdint.h>
#include <mem.h>
#include <buildconf.h>
#include <graphics/textmode.h>
#include <panic.h>

struct idt_descriptor
{
    uint16_t offset_1; // 0 - 15
    uint16_t selector; // gdt selector
    uint8_t zero;
    uint8_t type_attr;
    uint16_t offset_2; // upper offset bits 16-31
} __attribute__((packed));

struct idtr_descriptor
{
    uint16_t limit; // size of table
    uint32_t base; // base addr start of IDT
} __attribute__((packed));

void load_idt();
