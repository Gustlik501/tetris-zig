const std = @import("std");
const rl = @import("raylib");


pub const Grid = struct {
    num_rows: u8,
    num_cols: u8,
    cell_size: i32,
    grid: [20][10]u8,
    colors: [8]rl.Color,

    
    pub fn init() Grid {
        return Grid {
            .num_rows = 20,
            .num_cols = 10,
            .cell_size = 30,
            .grid = undefined,
            .colors = .{
                rl.Color.init(26,31,40,255),
                .green,
                .red,
                .orange,
                .yellow,
                .purple,
                rl.Color.init(21, 204, 209, 255),
                .blue,
            },

        };
    }

    pub fn print(self: *const Grid) void {
        for (self.grid) |row| {
            for (row) |cell| {
                std.debug.print("{d} ", .{cell});
            }
            std.debug.print("\n", .{});
        }
    }


    pub fn draw(self: *const Grid) void {
        for (self.grid, 0..) |row, row_index| {
            for (row, 0..) |cell, cell_index| {
                const x = @as(i32, @intCast(cell_index));
                const y = @as(i32, @intCast(row_index));

                rl.drawRectangle(x * self.cell_size + 1, y * self.cell_size + 1, self.cell_size - 1, self.cell_size - 1, self.colors[cell]);
            }
        }
    }
    

    pub fn isCellOutOfBounds(self: *const Grid, x: i32, y: i32) bool {
        if (x < 0 or x >= self.num_cols or y < 0 or y >= self.num_rows) {
            return true;
        }
        return false;
    }

};

