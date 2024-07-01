#pragma once
#include <stdint.h>

uint16_t* vram = 0;

#define VRAM_ADDR 0xB80000

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

int pos_x;
int pos_y;

void vram_text_init();
void print(const char *data);
void printch(char ch, char color);
void terminal_clear();
uint16_t createColor(enum vga_color fg, enum vga_color bg) {
    return fg | bg << 4;
}

void setTerminalColor(uint16_t col);
