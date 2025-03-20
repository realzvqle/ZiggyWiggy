all:
	cd kernel && make

clean:
	cd kernel && make clean
	
run:
	make all
	qemu-system-aarch64 -M 6GB -machine virt -cpu neoverse-v1 -kernel kernel/zig-out/bin/kernel.sys -device ramfb  -device virtio-keyboard -display sdl -serial mon:stdio 