`timescale 1ns / 1ps

module controller(left, right, up, down, enter, game_reset);
    input left, right, up, down, enter, game_reset;
    
    wire trigger = left || right || up || down || enter || game_reset;
    
    reg [2:0] board [7:0][7:0];
    
    reg [2:0] i, k;
    
    always @(posedge trigger) begin
        if (game_reset) begin
            // reset board
        end
        else if (enter) begin
            // enter key is pressed to select thing
        end
        else if (left) begin
            // move left
        end
        else if (right) begin
            // move right
        end
        else if (up) begin
            // move up
        end
        else if (down) begin
            // move down
        end
    end

endmodule
