const uart = @import("uart/uart.zig");
const time = @import("timer/timer.zig");
const rtl = @import("runtimelib/runtimelib.zig");
const ex = @import("exception/exceptionhandler.zig");
const pcie = @import("pcie/pcie.zig");

extern fn start_interrupts() void;

pub export fn _begin_exception_handler(frame: *ex.interrupt_frame) void {
    ex.exception_handler(frame);
}

pub export fn kernel_entry() void {
    while (true) {
        pcie.pcie();
        pcie.write_to_pcie(u32, 10);
        time.halt_system_temporarily_seconds(1);
    }
}
