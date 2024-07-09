#!/bin/bash

echo "[========== MKBOOT UTILITY ==========]"

if [ "$1" = 'LEGACY' ];
then
    echo
    echo "======== Building bootloader for LEGACY"
    echo "----> Compiling stage 1 and 2...."
    nasm -f bin ./src/stage1/boot.asm -o bin/boot_legacy.bin
    if [ "$2" = '-bi' ];
    then
        echo "----> -bi specified, building devOS image...."
        echo "----> using kernel image $3"
        rm -rf ./bin/devOS.bin
        echo "----> Combining bootloader and kernel...."
        dd if=./bin/boot_legacy.bin >> ./bin/devOS.bin
        dd if=$3 >> ./bin/devOS.bin
        if [ "$4" = '--no-zeros' ];
        then
            echo "Complete!"
            exit
        fi

        echo "----> Finishing up...."
        dd if=/dev/zero bs=512 count=100 >> ./bin/devOS.bin
        echo "Complete!"
        exit
    fi
elif [ $1 == 'MULTIBOOT' ];
then
    nasm -felf32 ./src/stage2/32/grub/entry.s -o ./build/multiboot.o
    echo "[BUILDER] Linking multiboot kernel..."
    # we need to run i686-elf-gcc -T src/stage2/32/grub/multiboot.ld -o bin/multiboot_kernel -ffreestanding -O2 -nostdlib ./build/multiboot.o ./build/*.o -lgcc with somthing to allow multiple definitions
    i686-elf-gcc -T ./src/stage2/32/grub/multiboot.ld -o ./bin/multiboot_kernel -ffreestanding -O2 -nostdlib -z muldefs ./build/multiboot.o ./build/*.o -lgcc
    echo "[BUILDER] Building multiboot image..."
    grub-file --is-x86-multiboot ./bin/multiboot_kernel
    if [ $? -ne 0 ];
    then
        echo "[BUILDER] Error: Multiboot image not valid!"
        echo "[BUILDER] Did you supply a non legacy kernel?"
        exit
    fi
    echo "[BUILDER] Building multiboot image..."
    # build iso structure
    mkdir -p ./bin/iso/boot/grub
    cp ./bin/multiboot_kernel ./bin/iso/boot/kernel.bin
    cp ./src/stage2/32/grub/grub.cfg ./bin/iso/boot/grub/grub.cfg
    grub-mkrescue -o ./bin/devOS.iso ./bin/iso
    echo "[BUILDER] Complete!"
elif [ $1 == 'EFI' ];
then
    echo "===> wait till 64 bit support to use EFI!"
else
    echo "UKNOWN BOOT TYPE! $1"
fi
