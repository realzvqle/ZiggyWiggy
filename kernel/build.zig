const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .aarch64,
        .os_tag = .freestanding,
        .abi = .none,
    });

    const optimize = b.standardOptimizeOption(.{ .preferred_optimize_mode = std.builtin.OptimizeMode.Debug });

    const exe = b.addExecutable(.{
        .name = "kernel.sys",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.setLinkerScript(b.path("linker.ld"));
    exe.addObjectFile(b.path("boot.o"));
    exe.addAssemblyFile(b.path("src/exception/exceptions.S"));
    b.installArtifact(exe);
    const lib = b.addStaticLibrary(.{
        .name = "kernel",
        .root_source_file = b.path("src/lib.zig"),
        .target = target,
        .optimize = optimize,
    });
    lib.addAssemblyFile(b.path("src/exception/exceptions.S"));
    b.installArtifact(lib);
}
