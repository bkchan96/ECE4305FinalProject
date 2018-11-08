`timescale 1ns / 1ps

module kb_controller
    (
        input wire clk, reset,
        input wire [7:0] scan_code_read,
        input wire scan_done_tick,
        input wire [7:0] scan_code,
        output reg key
    );
    
    wire scan_done_tick;
    wire [7:0] scan_code;
    
    localparam [1:0]
        idle    = 2'b00,
        state1  = 2'b01,
        state2  = 2'b10;
    
    reg [1:0] current_state, next_state;
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            current_state <= idle;
        else
            current_state <= next_state;
    end
    
    always @*
    begin
 //       next_state <= next_state;
        case (current_state)
            idle:
                begin
                    key = 0;
                    if (scan_done_tick && scan_code == scan_code_read)
                        next_state = state1;
                    else
                        next_state = idle;
                end
            state1:
                begin
                    key = 1;
                    if (scan_done_tick && scan_code == 8'hf0)
                        next_state = state2;
                    else
                        next_state = state1;
                end
            state2:
                begin
                    if (scan_done_tick && scan_code == scan_code_read)
                        next_state = idle;
                    else
                        next_state = state2;
                end
            default:
                begin
                    next_state = idle;
                end
        endcase
    end
    
endmodule