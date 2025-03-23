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
    var i: u32 = 0;
    while (true) {
        // will error out, will fix this soon
        const string = alloc.allocate_memory(1 + i) orelse err.sys_panic("failure to allocate memory\n");
        alloc.read_header_data(string);
        alloc.free_memory(string);
        //alloc.read_header_data(string);
        uart.uart_print("Allocated Memory...\n");
        time.halt_system_temporarily_seconds(1);
        i = i + 1;
    }
}
