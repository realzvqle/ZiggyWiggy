pub fn integer_to_string(comptime T: type, int: T) []const u8 {
    var i: u32 = 0;
    var num = int;
    var buffer: [16]u8 = undefined;
    if (num == 0) {
        buffer[i] = '0';
        i += 1;
    } else {
        // no do while =(
        buffer[i] = @intCast((num % 10) + '0');
        num /= 10;
        i += 1;
        while (num > 0) {
            buffer[i] = @intCast((num % 10) + '0');
            num /= 10;
            i += 1;
        }
    }
    var final: [16]u8 = undefined;
    var index: u32 = 0;
    for (buffer[0..i]) |_| {
        final[index] = buffer[i - 1 - index];
        index += 1;
    }
    return final[0..index];
}
