const UART0_DR: *volatile u32 = @ptrFromInt(0x09000000);

fn KiWriteCharacterIntoUart(byte: u8) void {
    UART0_DR.* = byte;
}

pub fn KiPrintIntoUart(array: []const u8) void {
    for (array) |char| {
        KiWriteCharacterIntoUart(char);
    }
}
