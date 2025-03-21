const mem = @import("../mem/mem.zig");
const uart = @import("../uart/uart.zig");
const rtl = @import("../runtimelib/runtimelib.zig");

// testing, not really anything else going on
// just messing around, not a valid PCIE driver

const PCIEAddress: u32 = 0x10000000;
const PCIE: *volatile u32 = @ptrFromInt(PCIEAddress);

pub fn read_pci_register(offset: u32) u32 {
    const result: *volatile u32 = @ptrFromInt(PCIEAddress + offset);
    return mem.read(result);
}

pub fn write_pci_register(comptime T: type, value: T, offset: u32) void {
    const result: *volatile u32 = @ptrFromInt(PCIEAddress + offset);
    mem.write(T, value, result);
}

pub fn pcie() void {
    const res = read_pci_register(0x00);
    const string = rtl.integer_to_string(u32, res);
    uart.uart_print(string);
    uart.write_into_uart('\n');
}

pub fn write_to_pcie(comptime T: type, value: T) void {
    write_pci_register(T, value, 0x00);
}
