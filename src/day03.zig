const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day03.txt");
// const data = @embedFile("../data/day03-tst.txt");

pub fn main() !void {
    var grid = try Grid.init();

    // Part1
    // const slopes = [1][2]usize{
    //     [2]usize{ 3, 1 },
    // };

    const slopes = [5][2]usize{
        [2]usize{ 1, 1 },
        [2]usize{ 3, 1 },
        [2]usize{ 5, 1 },
        [2]usize{ 7, 1 },
        [2]usize{ 1, 2 },
    };

    var mult: usize = 1;

    for (slopes) |slope| {
        var i: usize = 0;
        var j: usize = 0;

        var cpt: usize = 0;
        while (j < grid.h) : ({
            i += slope[0];
            j += slope[1];
        }) {
            if (grid.hasTree(i, j)) {
                cpt += 1;
            }
        }
        mult *= cpt;
    }

    print("{}\n", .{mult});
}

const Grid = struct {
    w: usize,
    h: usize,
    trees: List(bool),

    fn init() !Grid {
        var grid = Grid{
            .w = 0,
            .h = 0,
            .trees = List(bool).init(gpa),
        };

        var it = tokenize(u8, data, "\r\n");
        while (it.next()) |line| {
            if (grid.w == 0) {
                grid.w = line.len;
            }
            assert(grid.w == line.len);

            grid.h += 1;

            for (line) |c| {
                try grid.trees.append(c == '#');
            }
        }

        return grid;
    }

    fn hasTree(self: Grid, i: usize, j: usize) bool {
        return self.trees.items[(i % self.w) + j * self.w];
    }
};

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
