const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;
const Str = []const u8;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("../data/day04.txt");
// const data = @embedFile("../data/day04-tst.txt");

pub fn main() !void {
    var it = split(u8, data, "\n");

    var passports = List(std.BufMap).init(gpa);
    var current_passport = std.BufMap.init(gpa);

    // Make this false for part1 result
    const part2 = true;

    while (true) {
        var line = it.next();
        if (line == null or line.?.len == 0) {
            try passports.append(current_passport);
            current_passport = std.BufMap.init(gpa);

            if (line == null) {
                break;
            }
            continue;
        }

        var entries = tokenize(u8, line.?, "\n\r ");
        while (entries.next()) |entry| {
            var split_entry = tokenize(u8, entry, ":");

            var key = split_entry.next().?;
            var value = split_entry.next().?;

            // cid is optional. Just ignore it
            if (!std.mem.eql(u8, key, "cid")) {
                try current_passport.put(key, value);
            }
        }
    }

    const eye_colors = blk: {
        var tmp = std.BufSet.init(gpa);
        try tmp.insert("amb");
        try tmp.insert("blu");
        try tmp.insert("brn");
        try tmp.insert("gry");
        try tmp.insert("grn");
        try tmp.insert("hzl");
        try tmp.insert("oth");
        break :blk tmp;
    };

    var valid_passports: usize = 0;
    for (passports.items) |passport| {
        if (passport.count() == 7) {
            if (part2) {
                var byr = parseInt(u32, passport.get("byr").?, 10) catch 0;
                if (byr < 1920 or byr > 2002) continue;

                var iyr = parseInt(u32, passport.get("iyr").?, 10) catch 0;
                if (iyr < 2010 or iyr > 2020) continue;

                var eyr = parseInt(u32, passport.get("eyr").?, 10) catch 0;
                if (eyr < 2020 or eyr > 2030) continue;

                var hgt_str = passport.get("hgt").?;
                if (std.mem.count(u8, hgt_str, "in") > 0) {
                    var hgt = parseInt(u16, hgt_str[0 .. hgt_str.len - 2], 10) catch 0;
                    if (hgt < 59 or hgt > 76) continue;
                } else if (std.mem.count(u8, hgt_str, "cm") > 0) {
                    var hgt = parseInt(u16, hgt_str[0 .. hgt_str.len - 2], 10) catch 0;
                    if (hgt < 150 or hgt > 193) continue;
                } else {
                    continue;
                }

                var hcl = passport.get("hcl").?;
                if (hcl.len != 7) continue;
                if (hcl[0] != '#') continue;
                var valid_hcl = true;
                for (hcl[1..]) |c| {
                    if ((c < '0' or c > '9') and (c < 'a' or c > 'f')) {
                        valid_hcl = false;
                        break;
                    }
                }
                if (!valid_hcl) continue;

                var ecl = passport.get("ecl").?;
                if (!eye_colors.contains(ecl)) continue;

                var pid = passport.get("pid").?;
                if (pid.len != 9) continue;
                var valid_pid = true;
                for (pid) |c| {
                    if (c < '0' or c > '9') {
                        valid_pid = false;
                        break;
                    }
                }
                if (!valid_pid) continue;
            }
            valid_passports += 1;
        }
    }

    print("{}\n", .{valid_passports});
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
