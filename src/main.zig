// raylib-zig (c) Nikolas Wipper 2023

const rl = @import("raylib");
const std = @import("std");



const Button = @import("button.zig").Button;
const Grid = @import("grid.zig").Grid;
const tetormino = @import("tetromino.zig");


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

    rl.setTargetFPS(1); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
    // const buttonText = "Click Me";
    // const buttonRect = rl.Rectangle{
    //     .x = 100,
    //     .y = 100,
    //     .width = 200,
    //     .height = 50,
    // };

    const grid = Grid.init();
    grid.print();


    var block = tetormino.I;
    
    // const button = Button.init(buttonRect, buttonText, onButtonPressed);


    // Main game loop
    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------
        //const mousePos = rl.getMousePosition();
        //const mousePressed = rl.isMouseButtonPressed(.left);
       // block.rotate();

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(dark_blue);
        grid.draw();
        block.draw();
        //button.draw();
        //rl.drawText("Congrats! You created your first window!", 190, 200, 20, .light_gray);
        //----------------------------------------------------------------------------------
    }
}
