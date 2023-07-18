```
~/bochs/bin/bximage
# hd flat 60 hd60M.image

nasm -o ./mbr ./mbr.S -I ./include/
dd if=./mbr of=./h60M.img bs=512 count=1 conv=notrunc

nasm -o ./loader ./loader.S -I ./include/
dd if=./loader of=./h60M.img bs=512 count=1 conv=notrunc seek=2

cp ./hd60M.img ~/bochs/

cd ~/bochs
./bin/bochs -f bochsrc.disk
```

