#pragma once
#include <stdint.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 20

uint16_t mkchar(char ch, char color) {
    return (color << 8) | ch;
}
