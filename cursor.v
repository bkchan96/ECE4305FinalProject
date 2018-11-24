`timescale 1ns / 1ps

module cursor
    (
        input [9:0] pixel_x, pixel_y,
        input [9:0] top_left_x, top_left_y,
        output on,
        output reg [11:0] color
    );
    
    // load in and declare position and sizing of number
    localparam FOOTPRINT = 32;                                 
    wire [9:0] C_X_L = top_left_x;                   
    wire [9:0] C_Y_T = top_left_y;                  
    wire [9:0] C_X_R = C_X_L + FOOTPRINT - 1;
    wire [9:0] C_Y_B = C_Y_T + FOOTPRINT - 1;
    
    // declare signals to check
    wire [4:0] rom_addr, rom_col;
    wire rom_bit;
    wire sq_on;
    reg [0:31] rom_data;
    
    // check current position of pixel
    assign rom_addr = pixel_y[4:0] - C_Y_T[4:0];
    assign rom_col = pixel_x[4:0] - C_X_L[4:0];
    assign rom_bit = rom_data[rom_col];
    
    // enable on if within foot print
    assign sq_on =
       (C_X_L<=pixel_x) && (pixel_x<=C_X_R) &&
       (C_Y_T<=pixel_y) && (pixel_y<=C_Y_B);
    
    //enable
    assign on = sq_on & rom_bit;
    
    // determine number to output
    always @* begin
        color = 12'b000000000000; // black
        case (rom_addr)
            5'd0:  rom_data <=    32'b1111111111111111_1111111111111111;
            5'd1:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd2:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd3:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd4:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd5:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd6:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd7:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd8:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd9:  rom_data <=    32'b1000000000000000_0000000000000001;
            5'd10: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd11: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd12: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd13: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd14: rom_data <=    32'b1000000000000000_0000000000000001;         
            5'd15: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd16: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd17: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd18: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd19: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd20: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd21: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd22: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd23: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd24: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd25: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd26: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd27: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd28: rom_data <=    32'b1000000000000000_0000000000000001;   
            5'd29: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd30: rom_data <=    32'b1000000000000000_0000000000000001;
            5'd31: rom_data <=    32'b1111111111111111_1111111111111111;
        endcase
    end
endmodule