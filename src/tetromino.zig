const rl = @import("raylib");
const std = @import("std");

pub const TetrominoType = enum {
    I, O, T, S, Z, J, L,
};

pub const TetrominoArray = [_] Tetromino{ I, O, T, S, Z, J, L };

pub fn getRandomTetromino(rand: std.Random) Tetromino {
    return TetrominoArray[@intCast(rand.intRangeAtMost(u32, 0, 6))];
}

pub const Tetromino = struct {
    blockType: TetrominoType,
    pos: [2]i32,
    rotation: u8,
    shape: [4] []const []const u8,  //
    color: rl.Color,


    pub fn rotate(self: *Tetromino) void {
        self.rotation += 1;
        if (self.rotation > 3) {
            self.rotation = 0;
        }
    }

    pub fn undoRotation(self: *Tetromino) void {
        self.rotation -= 1;
        if (self.rotation < 0) {
            self.rotation = 3;
        }
    }

    pub fn draw(self: *const Tetromino) void {
        for (self.shape[self.rotation], 0..) |row, row_index| {
            for (row, 0..) |cell, cell_index| {
                if (cell == 0) continue;

                const x = @as(i32, @intCast(cell_index));
                const y = @as(i32, @intCast(row_index));

                rl.drawRectangle(
                    (self.pos[0] + x) * 30 + 1,
                    (self.pos[1] + y) * 30 + 1,
                    30 - 1,
                    30 - 1,
                    self.color,
                );

                
            }
        }
    }

    pub fn move(self: *Tetromino, x: i32, y: i32) void {
        self.pos[0] += x;
        self.pos[1] += y;
    }


};

pub const I = Tetromino{
    .blockType = .I,
    .pos = .{3, -1},
    .rotation = 0,
        .shape = [4][]const []const u8{
        // Rotation 0
        &[_][]const u8{
            &[_]u8{ 0, 0, 0, 0 },
            &[_]u8{ 1, 1, 1, 1 },
            &[_]u8{ 0, 0, 0, 0 },
            &[_]u8{ 0, 0, 0, 0 },
        },
        // Rotation 1
        &[_][]const u8{
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
        },
        // Rotation 2
        &[_][]const u8{
            &[_]u8{ 0, 0, 0, 0 },
            &[_]u8{ 0, 0, 0, 0 },
            &[_]u8{ 1, 1, 1, 1 },
            &[_]u8{ 0, 0, 0, 0 },
        },
        // Rotation 3
        &[_][]const u8{
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
            &[_]u8{ 0, 1, 0, 0 },
        },
    },
    .color = .green,
};

pub const O = Tetromino{
    .blockType = .O,
    .pos = .{4, 0},
    .rotation = 0,
    .shape = [4][]const []const u8{
        // Rotation 0
        &[_][]const u8{
            &[_]u8{ 1, 1 },
            &[_]u8{ 1, 1 },
        },
        &[_][]const u8{
            &[_]u8{ 1, 1 },
            &[_]u8{ 1, 1 },
        },
        &[_][]const u8{
            &[_]u8{ 1, 1 },
            &[_]u8{ 1, 1 },
        },
        &[_][]const u8{
            &[_]u8{ 1, 1 },
            &[_]u8{ 1, 1 },
        },
    },
    .color = .green,
};


pub const T = Tetromino{
    .blockType = .T,
    .pos = .{3, 0},
    .rotation = 0,
    .shape = [4][]const []const u8{
        // Rotation 0
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 0, 0, 0 }
        },
        // Rotation 1
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 1, 0 }
        },
        // Rotation 2
        &[_][]const u8{
            &[_]u8{ 0, 0, 0 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 0, 1, 0 }
        },
        // Rotation 3
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 0, 1, 0 }
        }
    },
    .color = .green,
};


pub const S = Tetromino{
    .blockType = .S,
    .pos = .{3, 0},
    .rotation = 0,
    .shape = [4][]const []const u8{
        &[_][]const u8{
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 0, 0, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 0, 1 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 0, 0 },
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 1, 1, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 1, 0, 0 },
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 0, 1, 0 }
        },
    },
    .color = .green,
};


pub const Z = Tetromino{
    .blockType = .Z,
    .pos = .{3, 0},
    .rotation = 0,
    .shape = [4][]const []const u8{
        &[_][]const u8{
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 0, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 0, 1 },
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 1, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 0, 0 },
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 0, 1, 1 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 1, 0, 0 }
        },
    },
    .color = .green,
};

pub const J = Tetromino{
    .blockType = .J,
    .pos = .{3, 0},
    .rotation = 0,
        .shape = [4][]const []const u8{
        &[_][]const u8{
            &[_]u8{ 1, 0, 0 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 0, 0, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 0, 1, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 0, 0 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 0, 0, 1 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 1, 1 },
            &[_]u8{ 0, 0, 1 },
            &[_]u8{ 0, 0, 1 }
        },
    },
    .color = .green,
};

pub const L = Tetromino{
    .blockType = .L,
    .pos = .{3, 0},
    .rotation = 0,
    .shape = [4][]const []const u8{
        &[_][]const u8{
            &[_]u8{ 0, 0, 1 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 0, 0, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 0, 1, 0 },
            &[_]u8{ 0, 1, 1 }
        },
        &[_][]const u8{
            &[_]u8{ 0, 0, 0 },
            &[_]u8{ 1, 1, 1 },
            &[_]u8{ 1, 0, 0 }
        },
        &[_][]const u8{
            &[_]u8{ 1, 1, 0 },
            &[_]u8{ 1, 0, 0 },
            &[_]u8{ 1, 0, 0 }
        },
    },
    .color = .green,
};
