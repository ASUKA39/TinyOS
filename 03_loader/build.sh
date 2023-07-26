#!/bin/bash

rm -rf ./build/*
rm ~/bochs/hd60M.img

cd build
# ~/bochs/bin/bximage -hd -mode=flat -size=60M -q hd60M.img
printf "hd\nflat\n60\nhd60M.img\n" | ~/bochs/bin/bximage
cd ../

nasm -o ./build/mbr ./boot/mbr.S -I ./boot/include/
dd if=./build/mbr of=./build/hd60M.img bs=512 count=1 conv=notrunc

nasm -o ./build/loader ./boot/loader.S -I ./boot/include/
dd if=./build/loader of=./build/hd60M.img bs=512 count=4 conv=notrunc seek=2

gcc -o ./build/main.o -c -m32 ./kernel/main.c
ld -m elf_i386 -Ttext 0x00001500 -e main -o ./build/kernel.bin  ./build/main.o
dd if=./build/kernel.bin of=./build/hd60M.img bs=512 count=200 conv=notrunc seek=9

cp ./build/hd60M.img ~/bochs/

printf "c" | ~/bochs/bin/bochs -q -f ~/bochs/bochsrc.disk