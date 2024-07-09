
#!/bin/bash

includes="-I ./inc/kernel/"
cxxflags="-g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 $includes"
cxx=i686-elf-gcc
ld=i686-elf-ld
asm=nasm
boot_type=MULTIBOOT

echo "=============== MAKE MULTIBOOT KERNEL UTILITY ==============="
echo "----> Compiling kernel...."
#echo "--> Building kernel entry...."
# this is the legacy boot entry, we dont want that
#$asm -f elf ./src/kernel/kernel.sasm -o ./build/kernel-load.fo
# We dont want a entry, mkboot.sh will handle that
echo "--> Building kernel...."

for i in ./src/kernel/*.c
do
    echo "--> Building: $i"
    $cxx -c $i -o ./build/$(basename $i).o -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-unused-parameter -nostdlib -fcommon -I ./inc/kernel
done

for i in ./src/kernel/*.asm
do
    echo "--> Building: $i"
    $asm -f elf -g $i -o ./build/$(basename $i).o
done

for i in ./src/kernel/x86/*.asm
do
    echo "--> Building: $i"
    $asm -f elf -g $i -o ./build/$(basename $i).o
done

for i in ./src/kernel/x86/*.c
do
    echo "--> Building: $i"
    $cxx -c $i -o ./build/$(basename $i).o -ffreestanding -O0 -nostdlib -I ./inc/kernel -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-unused-parameter -nostdlib -fcommon
done

echo "----> All objects built, its up to mkboot.sh now!"
#echo "--> Building kernel-elf.elf..."
#$ld -g -relocatable ./build/kernel-load.fo ./build/*.o -o ./build/kernel-elf.elf --allow-multiple-definition
#$ld -g -relocatable ./build/*.o -o ./build/kernel-mb.elf --allow-multiple-definition
#echo "--> Converting into flat binary..."
#$cxx -g -T ./src/kernel/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernel-elf.elf -lgcc
echo "--> Cleaning...."
if [ "$1" = '--buildrun' ];
then
    echo "----> Building boot, and running..."
    ./util/mkboot.sh $boot_type -bi ./bin/kernel.bin
fi