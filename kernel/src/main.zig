const uart = @import("uart/uart.zig");

pub export fn KiEntry() void {
    uart.KiPrintIntoUart("Hi\nF");
}
