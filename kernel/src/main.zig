const uart = @import("uart/uart.zig");
const time = @import("timer/timer.zig");
const rtl = @import("runtimelib/runtimelib.zig");
const ex = @import("exception/exceptionhandler.zig");
const pcie = @import("pcie/pcie.zig");
const mem = @import("memory/mem.zig");
const alloc = @import("memory/allocater/allocater.zig");
const err = @import("misc/error.zig");

extern fn start_interrupts() void;

pub export fn _begin_exception_handler(frame: *ex.interrupt_frame) void {
    ex.exception_handler(frame);
}

pub export fn kernel_entry() void {
    alloc.init_allocater(0x41000000, 100);
    while (true) {
        // will error out, will fix this soon
        const string = alloc.allocate_memory(5) orelse err.sys_panic("failure to allocate memory\n");
        alloc.free_memory(string);
        uart.uart_print("Allocated 5 Byte...\n");
        time.halt_system_temporarily_seconds(1);
    }
}
