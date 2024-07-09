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
    echo "============ MULTIBOOT SUPPORT IS COMING SOON......"
elif [ $1 == 'EFI' ];
then
    echo "===> wait till 64 bit support to use EFI!"
else
    echo "UKNOWN BOOT TYPE! $1"
fi
