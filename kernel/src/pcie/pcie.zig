const mmio = @import("../mmio/mmio.zig");
const uart = @import("../uart/uart.zig");
const rtl = @import("../runtimelib/runtimelib.zig");

// testing, not really anything else going on
// just messing around, not a valid PCIE driver

const PCIE: *volatile u32 = @ptrFromInt(0x10000000);

pub fn pcie() void {
    const res = mmio.read(PCIE);
    const string = rtl.integer_to_string(u32, res);
    uart.uart_print(string);
}

pub fn write_to_pcie(comptime T: type, value: T) void {
    mmio.write(T, value, PCIE);
}
