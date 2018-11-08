`timescale 1ns / 1ps

module LFSR(clk, random);
    input clk;
    output [2:0] random;
 
    // declare signals
    reg [3:1] register = 0;
    wire r_XNOR;

    always @(posedge clk) begin
            register <= {register[2:1], r_XNOR};
    end
    
    // assign feedback
    assign r_XNOR = register[3] ^~ register[2];
 
    // assign output
    assign random = register[3:1];
endmodule