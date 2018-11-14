`timescale 1ns / 1ps

module display(video_on, pix_x, pix_y, graph_rgb, clk, reset, left, right, up, down, enter, game_reset);
    input clk, reset;
    input left, right, up, down, enter, game_reset;
    input video_on;
    input [9:0] pix_x, pix_y;
    output reg [11:0] graph_rgb;
    
    //----------------------------------------------------------------------------------------------------
    // Game Control
    //----------------------------------------------------------------------------------------------------
    
    // declare board
    reg [2:0] board [7:0][7:0];
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Keyboard Input
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // declare and initilialize trigger flag
    wire trigger = left || right || up || down || enter;
    
    // take keyboard input
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
    
    // reset routine
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            counter1 <= 0;
            counter2 <= 0;
        end
        else begin
            if (game_reset) begin
                // reset complete if both counters are 7
                if (counter1 == 7 && counter2 == 7) begin
                    counter1 <= 0;
                    counter2 <= 0;
                end
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
                            counter1 <= counter1 + 1;
                        end
                    end
                end
            end
        end
    end
    
    //----------------------------------------------------------------------------------------------------
    // Display
    //----------------------------------------------------------------------------------------------------
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // instantiating display symbols
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // declare all variables    
    wire s_on[7:0][7:0];
    wire [11:0] color[7:0][7:0];
    
    // always [row][column]
    
    // zeroth row
    symbol u_symbol00(.value(board[0][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(112), .on(s_on[0][0]), .color(color[0][0]));
    symbol u_symbol01(.value(board[0][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(112), .on(s_on[0][1]), .color(color[0][1]));
    symbol u_symbol02(.value(board[0][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(112), .on(s_on[0][2]), .color(color[0][2]));
    symbol u_symbol03(.value(board[0][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(112), .on(s_on[0][3]), .color(color[0][3]));
    symbol u_symbol04(.value(board[0][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(112), .on(s_on[0][4]), .color(color[0][4]));
    symbol u_symbol05(.value(board[0][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(112), .on(s_on[0][5]), .color(color[0][5]));
    symbol u_symbol06(.value(board[0][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(112), .on(s_on[0][6]), .color(color[0][6]));
    symbol u_symbol07(.value(board[0][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(112), .on(s_on[0][7]), .color(color[0][7]));
    
    // first row
    symbol u_symbol10(.value(board[1][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(144), .on(s_on[1][0]), .color(color[1][0]));
    symbol u_symbol11(.value(board[1][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(144), .on(s_on[1][1]), .color(color[1][1]));
    symbol u_symbol12(.value(board[1][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(144), .on(s_on[1][2]), .color(color[1][2]));
    symbol u_symbol13(.value(board[1][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(144), .on(s_on[1][3]), .color(color[1][3]));
    symbol u_symbol14(.value(board[1][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(144), .on(s_on[1][4]), .color(color[1][4]));
    symbol u_symbol15(.value(board[1][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(144), .on(s_on[1][5]), .color(color[1][5]));
    symbol u_symbol16(.value(board[1][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(144), .on(s_on[1][6]), .color(color[1][6]));
    symbol u_symbol17(.value(board[1][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(144), .on(s_on[1][7]), .color(color[1][7]));
    
    // second row                                                                                                                                       
    symbol u_symbol20(.value(board[2][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(176), .on(s_on[2][0]), .color(color[2][0]));
    symbol u_symbol21(.value(board[2][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(176), .on(s_on[2][1]), .color(color[2][1]));
    symbol u_symbol22(.value(board[2][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(176), .on(s_on[2][2]), .color(color[2][2]));
    symbol u_symbol23(.value(board[2][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(176), .on(s_on[2][3]), .color(color[2][3]));
    symbol u_symbol24(.value(board[2][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(176), .on(s_on[2][4]), .color(color[2][4]));
    symbol u_symbol25(.value(board[2][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(176), .on(s_on[2][5]), .color(color[2][5]));
    symbol u_symbol26(.value(board[2][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(176), .on(s_on[2][6]), .color(color[2][6]));
    symbol u_symbol27(.value(board[2][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(176), .on(s_on[2][7]), .color(color[2][7]));
    
    // third row                                                                                                                                       
    symbol u_symbol30(.value(board[3][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(208), .on(s_on[3][0]), .color(color[3][0]));
    symbol u_symbol31(.value(board[3][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(208), .on(s_on[3][1]), .color(color[3][1]));
    symbol u_symbol32(.value(board[3][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(208), .on(s_on[3][2]), .color(color[3][2]));
    symbol u_symbol33(.value(board[3][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(208), .on(s_on[3][3]), .color(color[3][3]));
    symbol u_symbol34(.value(board[3][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(208), .on(s_on[3][4]), .color(color[3][4]));
    symbol u_symbol35(.value(board[3][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(208), .on(s_on[3][5]), .color(color[3][5]));
    symbol u_symbol36(.value(board[3][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(208), .on(s_on[3][6]), .color(color[3][6]));
    symbol u_symbol37(.value(board[3][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(208), .on(s_on[3][7]), .color(color[3][7]));
    
    // fourth row                                                                                                                                       
    symbol u_symbol40(.value(board[4][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(240), .on(s_on[4][0]), .color(color[4][0]));
    symbol u_symbol41(.value(board[4][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(240), .on(s_on[4][1]), .color(color[4][1]));
    symbol u_symbol42(.value(board[4][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(240), .on(s_on[4][2]), .color(color[4][2]));
    symbol u_symbol43(.value(board[4][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(240), .on(s_on[4][3]), .color(color[4][3]));
    symbol u_symbol44(.value(board[4][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(240), .on(s_on[4][4]), .color(color[4][4]));
    symbol u_symbol45(.value(board[4][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(240), .on(s_on[4][5]), .color(color[4][5]));
    symbol u_symbol46(.value(board[4][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(240), .on(s_on[4][6]), .color(color[4][6]));         
    symbol u_symbol47(.value(board[4][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(240), .on(s_on[4][7]), .color(color[4][7]));
    
    // fifth row                                                                                                                                       
    symbol u_symbol50(.value(board[5][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(272), .on(s_on[5][0]), .color(color[5][0]));
    symbol u_symbol51(.value(board[5][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(272), .on(s_on[5][1]), .color(color[5][1]));
    symbol u_symbol52(.value(board[5][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(272), .on(s_on[5][2]), .color(color[5][2]));
    symbol u_symbol53(.value(board[5][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(272), .on(s_on[5][3]), .color(color[5][3]));
    symbol u_symbol54(.value(board[5][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(272), .on(s_on[5][4]), .color(color[5][4]));
    symbol u_symbol55(.value(board[5][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(272), .on(s_on[5][5]), .color(color[5][5]));
    symbol u_symbol56(.value(board[5][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(272), .on(s_on[5][6]), .color(color[5][6]));
    symbol u_symbol57(.value(board[5][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(272), .on(s_on[5][7]), .color(color[5][7]));
    
    // sixth row                                                                                                                                       
    symbol u_symbol60(.value(board[6][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(304), .on(s_on[6][0]), .color(color[6][0]));
    symbol u_symbol61(.value(board[6][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(304), .on(s_on[6][1]), .color(color[6][1]));
    symbol u_symbol62(.value(board[6][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(304), .on(s_on[6][2]), .color(color[6][2]));
    symbol u_symbol63(.value(board[6][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(304), .on(s_on[6][3]), .color(color[6][3]));
    symbol u_symbol64(.value(board[6][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(304), .on(s_on[6][4]), .color(color[6][4]));
    symbol u_symbol65(.value(board[6][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(304), .on(s_on[6][5]), .color(color[6][5]));
    symbol u_symbol66(.value(board[6][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(304), .on(s_on[6][6]), .color(color[6][6]));
    symbol u_symbol67(.value(board[6][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(304), .on(s_on[6][7]), .color(color[6][7]));
    
    // seventh row                                                                                                                                       
    symbol u_symbol70(.value(board[7][0]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(272), .top_left_y(336), .on(s_on[7][0]), .color(color[7][0]));
    symbol u_symbol71(.value(board[7][1]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(304), .top_left_y(336), .on(s_on[7][1]), .color(color[7][1]));
    symbol u_symbol72(.value(board[7][2]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(336), .top_left_y(336), .on(s_on[7][2]), .color(color[7][2]));
    symbol u_symbol73(.value(board[7][3]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(368), .top_left_y(336), .on(s_on[7][3]), .color(color[7][3]));
    symbol u_symbol74(.value(board[7][4]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(400), .top_left_y(336), .on(s_on[7][4]), .color(color[7][4]));
    symbol u_symbol75(.value(board[7][5]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(432), .top_left_y(336), .on(s_on[7][5]), .color(color[7][5]));
    symbol u_symbol76(.value(board[7][6]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(464), .top_left_y(336), .on(s_on[7][6]), .color(color[7][6]));
    symbol u_symbol77(.value(board[7][7]), .pixel_x(pix_x), .pixel_y(pix_y), .top_left_x(496), .top_left_y(336), .on(s_on[7][7]), .color(color[7][7]));
    //omg dear lord someone please send help
    //inb4 takes an hour to generate bitstream
    //muh verilog
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // rgb multiplexing circuit
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // color parameters
    localparam WHITE    = 12'b111111111111;
    localparam BLACK    = 12'b000000000000;
    
    // looping variables
    reg [7:0] i, k;
    
    // declare symbol flag to determine if a symbol is being displayed
    wire sym_flag;
    assign sym_flag = s_on[0][0] | s_on[0][1] | s_on[0][2] | s_on[0][3] | s_on[0][4] | s_on[0][5] | s_on[0][6] | s_on[0][7] | 
                      s_on[1][0] | s_on[1][1] | s_on[1][2] | s_on[1][3] | s_on[1][4] | s_on[1][5] | s_on[1][6] | s_on[1][7] |
                      s_on[2][0] | s_on[2][1] | s_on[2][2] | s_on[2][3] | s_on[2][4] | s_on[2][5] | s_on[2][6] | s_on[2][7] |
                      s_on[3][0] | s_on[3][1] | s_on[3][2] | s_on[3][3] | s_on[3][4] | s_on[3][5] | s_on[3][6] | s_on[3][7] |
                      s_on[4][0] | s_on[4][1] | s_on[4][2] | s_on[4][3] | s_on[4][4] | s_on[4][5] | s_on[4][6] | s_on[4][7] |
                      s_on[5][0] | s_on[5][1] | s_on[5][2] | s_on[5][3] | s_on[5][4] | s_on[5][5] | s_on[5][6] | s_on[5][7] |
                      s_on[6][0] | s_on[6][1] | s_on[6][2] | s_on[6][3] | s_on[6][4] | s_on[6][5] | s_on[6][6] | s_on[6][7] |
                      s_on[7][0] | s_on[7][1] | s_on[7][2] | s_on[7][3] | s_on[7][4] | s_on[7][5] | s_on[7][6] | s_on[7][7];
    
    always @*
        if (~video_on)
            graph_rgb = BLACK; // blank
        else begin
            if (sym_flag) begin
                for (i = 0; i < 8; i = i + 1) begin
                    for (k = 0; k < 8; k = k + 1) begin
                        if (s_on[i][k] == 1)
                            graph_rgb <= color[i][k];
                    end
                end
            end
            else
                graph_rgb = WHITE;
        end

endmodule