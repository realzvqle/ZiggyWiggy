const mmio = @import("../mmio/mmio.zig");

const UART: *volatile u32 = @ptrFromInt(0x09000000);

pub fn write_into_uart(byte: u8) void {
    mmio.write(u8, byte, UART);
}

pub fn read_uart() u32 {
    return mmio.read(UART);
}

pub fn uart_print(array: []const u8) void {
    for (array) |char| {
        write_into_uart(char);
    }
}
