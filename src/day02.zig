const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day02.txt");

pub fn main() !void {
    var it = tokenize(u8, data, "\r\n");

    var part1: u32 = 0;
    var part2: u32 = 0;

    while (it.next()) |line| {
        var pwd_it = tokenize(u8, line, " -:");

        var n1 = try parseInt(u32, pwd_it.next().?, 10);
        var n2 = try parseInt(u32, pwd_it.next().?, 10);
        var letter = pwd_it.next().?[0];
        var str = pwd_it.next().?;

        var letter_cpt: u32 = 0;
        for (str) |c| {
            if (c == letter) {
                letter_cpt += 1;
            }
        }

        if (n1 <= letter_cpt and letter_cpt <= n2) {
            part1 += 1;
        }

        if ((str[n1 - 1] == letter and str[n2 - 1] != letter) or (str[n1 - 1] != letter and str[n2 - 1] == letter)) {
            part2 += 1;
        }
    }

    print("{} {}\n", .{ part1, part2 });
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;
