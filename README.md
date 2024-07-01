# devOS
random bootloader and kernel that only says stuff about the ccp
# How to build
have i686-elf-gcc (homebrew has it, you can install homebrew on macos and linux)<br>
run commands:
```
    git clone https://github.com/Alonecoder2011/devOS
    cd devOS
    ./util/mkkernel.sh --buildrun # that builds the bootloader and kernel
    run the bootloader:
    qemu-system-x86_64 -hda ./bin/devOS.bin
    Then nut
```
