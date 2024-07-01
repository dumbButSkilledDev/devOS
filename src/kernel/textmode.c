#include <graphics/textmode.h>
#include <graphics/vga.h>
#include <stdfunc.h>
// e
char terminalColor;

// initalize vram
void vram_text_init() {
    // turn the vram var into a refrence to the real vram.
    vram = (uint16_t*)(0xB8000);
    pos_x = 0;
    pos_y = 0;
    terminalColor = VGA_COLOR_WHITE | VGA_COLOR_BLACK << 4;

    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            vram[y * VGA_WIDTH + x] = mkchar(' ', terminalColor);
        }
    }
}

void terminal_clear() {
    for (size_t y = 0; y < VGA_HEIGHT; y++) {
        for (size_t x = 0; x < VGA_WIDTH; x++) {
            vram[y * VGA_WIDTH + x] = mkchar(' ', terminalColor);
        }
    }
}

// print char
void printch(char ch, char color) {
    if (ch == '\n') {
        pos_y++;
        pos_x=0;
    }  else {
        vram[pos_y * VGA_WIDTH + pos_x] = mkchar(ch, color);
    }

    if (++pos_x == VGA_WIDTH) {
       pos_x = 0;
       if (++pos_y == VGA_HEIGHT) {
           pos_y = 0;
       }
    }
}

// print function (regualar)
void print(const char *data) {
    for (uint16_t i = 0; i < strlen(data); i++) {
        printch(data[i], terminalColor);
    }
}

void setTerminalColor(uint16_t col) {
    terminalColor = col;
}
