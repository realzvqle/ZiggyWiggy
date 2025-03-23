pub fn write(comptime T: type, a: T, address: *volatile u32) void {
    address.* = a;
}

pub fn read(address: *volatile u32) u32 {
    return address.*;
}

pub fn write_to_memory(comptime T: type, a: T, address: u32) void {
    const addressptr: *volatile u32 = @ptrFromInt(address);
    addressptr.* = a;
}

pub fn read_memory(address: u32) u32 {
    const addressptr: *volatile u32 = @ptrFromInt(address);
    return addressptr.*;
}
