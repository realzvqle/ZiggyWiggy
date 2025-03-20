const UART0_DR: *volatile u32 = @ptrFromInt(0x09000000);

pub fn KiWriteCharacterIntoUart(byte: u8) void {
    UART0_DR.* = byte;
}

pub export fn KiEntry() void {
    KiWriteCharacterIntoUart('h');
}
