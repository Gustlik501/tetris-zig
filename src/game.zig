const std = @import("std");
const Grid = @import("grid.zig").Grid;
const tetormino = @import("tetromino.zig");
const rl = @import("raylib");


pub const Game = struct {
    grid: Grid,
    rand: std.Random,
    current_tetromino: tetormino.Tetromino,
    next_tetromino: tetormino.Tetromino,

    pub fn init() !Game {
        var seed: u64 = undefined;
        std.posix.getrandom(std.mem.asBytes(&seed)) catch |err| {
            std.debug.print("Failed to get random seed: {}\n", .{err});
            return err;
        };

        var prng = std.Random.DefaultPrng.init(seed);
        const rand = prng.random();

        return Game {
            .grid = Grid.init(),
            .rand = rand,
            .current_tetromino = tetormino.getRandomTetromino(rand),
            .next_tetromino = tetormino.getRandomTetromino(rand),
        };
    }


    pub fn draw(self: *const Game) void {
        self.grid.draw();
        self.current_tetromino.draw();
    }

    pub fn handleInput(self: *Game) void {
        const keyPressed = rl.getKeyPressed();
        switch (keyPressed) {
            .space => {
                self.current_tetromino.rotate();
                if (self.isBlockOutOfBounds()) {
                    self.current_tetromino.undoRotation();
                }
            },
            .right => {
                self.current_tetromino.move(1, 0);
                if (self.isBlockOutOfBounds()) {
                    self.current_tetromino.move(-1, 0);
                }
            },
            .left => {
                self.current_tetromino.move(-1, 0);
                if (self.isBlockOutOfBounds()) {
                    self.current_tetromino.move(1, 0);
                }
            },
            .down => {
                self.current_tetromino.move(0, 1);
                if (self.isBlockOutOfBounds()) {
                    self.current_tetromino.move(0, -1);
                }
            },
            else => {},
        }

    }   
    
    fn isBlockOutOfBounds(self: *const Game) bool {
        for (self.current_tetromino.shape[self.current_tetromino.rotation], 0..) |row, row_index| {
            for (row, 0..) |cell, cell_index| {
                if (cell == 0) continue;
                const x = @as(i32, @intCast(cell_index));
                const y = @as(i32, @intCast(row_index));
                if (self.grid.isCellOutOfBounds(self.current_tetromino.pos[0] + x, self.current_tetromino.pos[1] + y)) {
                    return true;
                }
            }
        } 
        return false;
    }
};

