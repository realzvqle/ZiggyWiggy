const mem = @import("../mem.zig");
const uart = @import("../../uart/uart.zig");

// Memory Allocater
// Kinda bad and doesn't work well, try to avoid this as much as possible =)

var start_address: u32 = undefined;
var heapsize: u32 = undefined;
const HEADER_SIZE: u32 = 8;

pub fn init_allocater(address: u32, size: u32) void {
    start_address = address;
    heapsize = size;
    mem.write_to_memory(u32, size, address);
    mem.write_to_memory(u32, 1, start_address + 4);
}

pub fn allocate_memory(size: u32) ?*u8 {
    var addr = start_address;
    while (addr < start_address + heapsize) {
        const block_size = mem.read_memory(addr);
        const is_free = mem.read_memory(addr + 4);
        if (is_free == 1 and block_size >= size + HEADER_SIZE) {
            mem.write_to_memory(u32, block_size, addr);
            mem.write_to_memory(u32, 0, addr + 4);
            const allocmem: *u8 = @ptrFromInt(addr + HEADER_SIZE);
            return allocmem;
        }
        addr += block_size;
    }
    uart.uart_print("OUT OF MEMORY\n");
    return null;
}

pub fn free_memory(ptr: *u8) void {
    const header_addr = @intFromPtr(ptr);
    const block_size = mem.read_memory(@intCast(header_addr));

    mem.write_to_memory(u32, block_size, @intCast(header_addr));
    mem.write_to_memory(u32, 1, @intCast(header_addr + 4));
}
