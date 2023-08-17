#!/bin/bash

# rm -rf ./build/*
rm ~/bochs/hd60M.img

cd build
# ~/bochs/bin/bximage -hd -mode=flat -size=60M -q hd60M.img
printf "hd\nflat\n60\nhd60M.img\n" | ~/bochs/bin/bximage
cd ../

nasm -o ./build/mbr ./boot/mbr.S -I ./boot/include/
dd if=./build/mbr of=./build/hd60M.img bs=512 count=1 conv=notrunc

nasm -o ./build/loader ./boot/loader.S -I ./boot/include/
dd if=./build/loader of=./build/hd60M.img bs=512 count=4 conv=notrunc seek=2

## only run in VM
# gcc -o ./build/main.o -c -m32 -I ./lib/kernel/ ./kernel/main.c
# nasm -f elf -o ./build/print.o ./lib/kernel/print.S
# nasm -f elf -o build/kernel.o kernel/kernel.S
# gcc -o ./build/interrput.o -c -fno-builtin -m32 -I ./lib/kernel/ -I ./lib/ -I ./kernel/ ./kernel/interrupt.c
# gcc -o ./build/init.o -c -fno-builtin -m32 -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -I ./device/ ./kernel/init.c
# gcc -o ./build/timer.o -c -fno-builtin -m32 -I ./lib/kernel/ -I ./lib/ -I ./kernel/ -I ./device/ ./device/timer.c
# ld -m elf_i386 -Ttext 0x00001500 -e main -o ./build/kernel.bin  ./build/main.o ./build/kernel.o ./build/timer.o ./build/init.o ./build/interrput.o ./build/print.o

dd if=./build/kernel.bin of=./build/hd60M.img bs=512 count=200 conv=notrunc seek=9

cp ./build/hd60M.img ~/bochs/

printf "c" | ~/bochs/bin/bochs -q -f ~/bochs/bochsrc.disk