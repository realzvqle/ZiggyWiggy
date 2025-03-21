const uart = @import("uart/uart.zig");
const time = @import("timer/timer.zig");

pub export fn kernel_entry() void {
    while (true) {
        uart.uart_print("hi\n");
        time.halt_system_temporarily_seconds(1);
    }
}
