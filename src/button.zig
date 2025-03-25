const rl = @import("raylib");

pub const Button = struct {
    rect: rl.Rectangle,
    text: [:0] const u8,
    action: fn () void,

    pub fn init(rect: rl.Rectangle, text: [:0]const u8, action: fn () void) Button {
        return Button{
            .rect = rect,
            .text = text,
            .action = action,
        };
    }

    pub fn draw(self: *const Button) void {
        rl.drawRectangleRec(self.rect, .red);
        // The following positions the text a few pixels inside the rectangle.
        rl.drawText(self.text, self.rect.x + 5, self.rect.y + 5, 20, .light_gray);
    }

    pub fn update(self: *const Button, mousePos: rl.Vector2, mousePressed: bool) void {
        if (mousePressed and rl.checkCollisionPointRec(mousePos, self.rect)) {
            // Execute the callback.
            self.action();
        }
    }

};