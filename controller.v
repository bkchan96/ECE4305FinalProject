`timescale 1ns / 1ps

module controller(clk, reset, left, right, up, down, enter, game_reset);
    input clk, reset;
    input left, right, up, down, enter, game_reset;
    
    wire trigger = left || right || up || down || enter;
    
    reg [2:0] board [7:0][7:0];
    
    always @(posedge trigger) begin
        if (enter) begin
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
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Reset Routine
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // declare wire and subtract by one because LFSR cannot output 0
    wire [2:0] rout, random;
    assign rout = random - 1;
    
    // instantiate random number generator
    LFSR u_LFSR(.clk(clk), .random(random));
    
    // declare counter to count up to 64
    reg [2:0] counter1, counter2;
    
    // declare register to store state
    reg state;
    
    // reset routine
    always @(posedge clk, posedge game_reset) begin
        if (reset) begin
            counter1 <= 0;
            counter2 <= 0;
            state <= 0;
        end
        if (game_reset) begin
            counter1 <= 0;
            counter2 <= 0;
            state <= 1;
        end
        if (state == 1) begin
            // reset complete if both counters are 7
            if (counter1 == 7 && counter2 == 7)
                state <= 0;
            
            // start reseting the board
            else begin
                // if random number is 5, throw away and do it on the next clock cycle
                if (rout < 5) begin
                    board[counter1][counter2] <= rout;
                    
                    // increment counters to run through all board spaces
                    if (counter1 == 7) begin
                        counter1 <= 0;
                        counter2 <= counter2 + 1;
                    end
                    else begin
                        counter1 = counter1 + 1;
                    end
                end
            end
        end
    end

endmodule
