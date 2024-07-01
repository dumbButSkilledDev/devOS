#!/bin/bash

if [ -e 'io.asm' ];
then
    echo "please call from root of devOS directory."
    exit
fi

echo "---> Building stage 1 and 2..."
nasm -f bin ./src/stage1/boot.asm -o ./bin/bootloader.bin
echo "NOTE: Stage 2 is include files only. no need to compile..."
