const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day05.txt");
// const data = @embedFile("../data/day05-tst.txt");

pub fn main() !void {
    var it = tokenize(u8, data, "\r\n");

    var sits = List(u16).init(gpa);

    while (it.next()) |line| {
        var row_min: u16 = 0;
        var row_max: u16 = 127;

        for (line[0..7]) |c| {
            if (c == 'B') {
                row_min = @divTrunc(row_max - row_min, 2) + row_min + 1;
            } else if (c == 'F') {
                row_max = @divTrunc(row_max - row_min, 2) + row_min;
            } else {
                unreachable;
            }
        }

        var col_min: u16 = 0;
        var col_max: u16 = 7;

        for (line[7..]) |c| {
            if (c == 'L') {
                col_max = @divTrunc(col_max - col_min, 2) + col_min;
            } else if (c == 'R') {
                col_min = @divTrunc(col_max - col_min, 2) + col_min + 1;
            } else {
                unreachable;
            }
        }

        try sits.append(row_min * 8 + col_min);
    }

    std.sort.sort(u16, sits.items, {}, comptime std.sort.asc(u16));

    var i: usize = 0;
    var missing: u16 = 0;
    while (i < sits.items.len - 1) : (i += 1) {
        if (sits.items[i + 1] != (sits.items[i] + 1)) {
            missing = sits.items[i] + 1;
            break;
        }
    }

    print("{} {}\n", .{ sits.items[sits.items.len - 1], missing });
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
