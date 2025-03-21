all:
	aarch64-none-elf-as src/boot/boot.asm -o boot.o
	zig build
clean:
	rm -rf .zig-cache
	rm -rf zig-out
	rm -rf boot.o