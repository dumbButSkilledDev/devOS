#include <panic.h>

void kernel_panic(const char *reason, const char *code) {
    setTerminalColor(VGA_COLOR_WHITE | VGA_COLOR_RED << 4);
    terminal_clear();
    print("KERNEL PANIC!\n");
    print("===================== why: ");
    print(reason);
    print(" =====================\n");
    print("error code: ");
    print(code);
    print("\n");
    print("Please Restart Your Computer!\n");
    while (1) {}
}
