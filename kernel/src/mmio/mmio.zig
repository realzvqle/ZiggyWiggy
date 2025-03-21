pub fn write(comptime T: type, a: T, address: *volatile u32) void {
    address.* = a;
}

pub fn read(address: *volatile u32) u32 {
    return address.*;
}
