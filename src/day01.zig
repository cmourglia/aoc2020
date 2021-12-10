const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day01.txt");
// const data = @embedFile("../data/day01-tst.txt");

pub fn main() !void {
    var list = List(u32).init(gpa);
    defer list.deinit();

    var it = tokenize(u8, data, "\r\n");
    while (it.next()) |num| {
        try list.append(try parseInt(u32, num, 10));
    }

    var i: usize = 0;
    var j: usize = 0;
    while (i < list.items.len - 1) : (i += 1) {
        j = i + 1;
        while (j < list.items.len) : (j += 1) {
            if (list.items[i] + list.items[j] == 2020) {
                print("{}\n", .{list.items[i] * list.items[j]});
            }
        }
    }

    i = 0;
    var k: usize = 0;
    while (i < list.items.len - 2) : (i += 1) {
        const n1 = list.items[i];
        j = i + 1;

        while (j < list.items.len - 1) : (j += 1) {
            const n2 = list.items[j];
            k = j + 1;

            while (k < list.items.len) : (k += 1) {
                const n3 = list.items[k];

                if (n1 + n2 + n3 == 2020) {
                    print("{}\n", .{n1 * n2 * n3});
                }
            }
        }
    }
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
