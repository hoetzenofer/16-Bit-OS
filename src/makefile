# makefile

all:
	nasm -f bin -o boot.bin boot.asm
	nasm -f bin -o kernel.bin kernel.asm
	dd if=/dev/zero of=floppy.img bs=512 count=2880
	dd if=boot.bin of=floppy.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=floppy.img bs=512 seek=1 conv=notrunc

run:
	qemu-system-i386 -fda floppy.img

clean:
	rm boot.bin kernel.bin floppy.img

