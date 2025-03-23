const uart = @import("../uart/uart.zig");

pub fn sys_panic(message: []const u8) noreturn {
    uart.uart_print(message);
    while (true) {
        continue;
    }
}
