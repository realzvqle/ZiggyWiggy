const mem = @import("../mem.zig");
const uart = @import("../../uart/uart.zig");
const rtl = @import("../../runtimelib/runtimelib.zig");
const err = @import("../../misc/error.zig");

// Memory Allocater
// Kinda bad and doesn't work well, try to avoid this as much as possible =)

// FLAGGED FOR REWRITING
var start_address: u32 = undefined;
var heapsize: u32 = undefined;
const HEADER_SIZE: u32 = 8;

pub fn init_allocator(address: u32, size: u32) void {
    start_address = address;
    heapsize = size;
    mem.write_to_memory(u32, 0, address);
    mem.write_to_memory(u32, 0, start_address + 4);
}

pub fn allocate_memory(size: u32) ?*u8 {
    var addr: u32 align(8) = start_address;
    while (addr < start_address + heapsize) {
        const block_size: u32 align(8) = mem.read_memory(addr);
        const is_free = mem.read_memory(addr + 4);
        if (is_free == 0 and (block_size >= size + HEADER_SIZE or block_size == 0)) {
            mem.write_to_memory(u32, size + HEADER_SIZE, addr);
            mem.write_to_memory(u32, 1, addr + 4);
            const allocmem: *u8 align(8) = @ptrFromInt(addr + HEADER_SIZE);
            return allocmem;
        }
        addr += block_size;
    }
    uart.uart_print("OUT OF MEMORY\n");
    return null;
}

pub fn free_memory(ptr: *u8) void {
    const header_addr = @intFromPtr(ptr);
    //const block_size = mem.read_memory(@intCast(header_addr - 8));
    mem.write_to_memory(u32, 0, @intCast(header_addr - 8));
    mem.write_to_memory(u32, 0, @intCast(header_addr - 4));
}

pub fn read_header_data(ptr: *u8) void {
    //const ptr: *u8 = ptrr orelse err.sys_panic("Something went wrong while freeing memory.....\n");
    const header_addr = @intFromPtr(ptr);
    const block_size = mem.read_memory(@intCast(header_addr - 8));
    const isfree = mem.read_memory(@intCast(header_addr - 4));

    uart.uart_print("\nSize (memory allocated is size - 8): ");
    const ssize = rtl.integer_to_string(u32, block_size);
    uart.uart_print(ssize);
    uart.uart_print("\nIs Free?: ");
    const sfree = rtl.integer_to_string(u32, isfree);
    uart.uart_print(sfree);
    uart.write_into_uart('\n');
}
