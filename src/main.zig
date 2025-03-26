// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");
const std = @import("std");



const Game = @import("game.zig").Game;


fn onButtonPressed() void {
    std.debug.print("Button was pressed!\n", .{});
}


pub fn main() anyerror!void {
    // Initialization
    //--------------------------------------------------------------------------------------
    const screenWidth = 300;
    const screenHeight = 600;

    const dark_blue = rl.Color.init(44, 44, 127, 255);

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second


    

    var game = try Game.init();



    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update

        game.handleInput();
        // Draw
        rl.beginDrawing();
        defer rl.endDrawing();
        game.draw();

        rl.clearBackground(dark_blue);


    }
}
