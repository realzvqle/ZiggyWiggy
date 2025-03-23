const rtl = @import("../runtimelib/runtimelib.zig");
const uart = @import("../uart/uart.zig");

pub const interrupt_frame = extern struct {
    x0: u64,
    x1: u64,
    x2: u64,
    x3: u64,
    x4: u64,
    x5: u64,
    x6: u64,
    x7: u64,
    x8: u64,
    x9: u64,
    x10: u64,
    x11: u64,
    x12: u64,
    x13: u64,
    x14: u64,
    x15: u64,
    x16: u64,
    x17: u64,
    x18: u64,
    fp: u64,
    lr: u64,
    xzr: u64,
    esr: u64,
    far: u64,
};

fn print_register(name: []const u8, register: u64) void {
    uart.uart_print(name);
    uart.uart_print(": ");
    const regstring = rtl.integer_to_string(u64, register);
    uart.uart_print(regstring);
    uart.write_into_uart('\n');
}

pub fn dump_interrupt_frame(frame: *interrupt_frame) void {
    print_register("x0", frame.x0);
    print_register("x1", frame.x1);
    print_register("x2", frame.x2);
    print_register("x3", frame.x3);
    print_register("x4", frame.x4);
    print_register("x5", frame.x5);
    print_register("x6", frame.x6);
    print_register("x7", frame.x7);
    print_register("x8", frame.x8);
    print_register("x9", frame.x9);
    print_register("x10", frame.x10);
    print_register("x11", frame.x11);
    print_register("x12", frame.x12);
    print_register("x13", frame.x13);
    print_register("x14", frame.x14);
    print_register("x15", frame.x15);
    print_register("x16", frame.x16);
    print_register("x17", frame.x17);
    print_register("x18", frame.x18);
    print_register("fp", frame.fp);
    print_register("lr", frame.lr);
    print_register("xzr", frame.xzr);
    print_register("esr", frame.esr);
    print_register("far", frame.far);
}

pub fn exception_handler(frame: *interrupt_frame) void {
    // will do more stuff here soon
    uart.uart_print("\n\n!! EXCEPTION OCCURED !!\n\n");
    dump_interrupt_frame(frame);
    while (true) {
        continue;
    }
}

pub fn panic(message: []const u8) void {
    uart.uart_print(message);
}
