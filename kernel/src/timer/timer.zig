const mem = @import("../memory/mem.zig");

const TIMER: *volatile u32 = @ptrFromInt(0x09010000);

pub fn read_counter() u32 {
    return mem.read(TIMER);
}

pub fn halt_system_temporarily_seconds(seconds: u32) void {
    const start_time = read_counter();
    const target_time = start_time + seconds;
    while (read_counter() < target_time) {
        continue;
    }
}
