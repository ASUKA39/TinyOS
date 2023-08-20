#!/bin/bash

rm ~/bochs/hd60M.img
cd ./build
printf "hd\nflat\n60\nhd60M.img\n" | ~/bochs/bin/bximage
cd ../

dd if=./build/mbr.o of=./build/hd60M.img bs=512 count=1 conv=notrunc
dd if=./build/loader.o of=./build/hd60M.img bs=512 count=4 conv=notrunc seek=2
dd if=./build/kernel.bin of=./build/hd60M.img bs=512 count=200 conv=notrunc seek=9

cp ./build/hd60M.img ~/bochs/

~/bochs/bin/bochs -q -f ~/bochs/bochsrc.disk