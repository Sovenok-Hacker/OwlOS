build:
	@echo "Building elf binary ..."
	@nasm -f elf32 boot.asm -o boot.o
	@gcc -m32 -c kernel.c -o kernel.o
	@ld -m elf_i386 -T link.ld -o os boot.o kernel.o

run:
	@echo "Running binary in QEMU ..."
	@qemu-system-i386 -kernel os

grub:
	@echo "Creating iso image with grub2 ..."
	@cp os image/boot/os-0.1
	@grub-mkrescue -o os.iso image

clear:
	@echo "Cleaning all created files ..."
	@rm -rf *.o os.iso os
	@rm -rf image/boot/os

isoboot:
	@echo "Booting iso file ..."
	@qemu-system-i386 -boot d -cdrom os.iso -m 512

usb:
	@echo "Writing iso to usb ..."
	@echo -n "Path to block file >> "
	@read path
	@sudo dd if=os.iso of=/dev/sdb status=progress
	@sudo grub-install /dev/sdb

restore:
	@echo "Restoring bakup ..."
	@rm -rf kernel.c
	@cp kernel.c.bak kernel.c
backup:
	@echo "Creating backup ..."
	@cp kernel.c.bak kernel.c
deps:
	@sudo apt install mtools nasm gcc qemu-system-i386 xorriso -y
