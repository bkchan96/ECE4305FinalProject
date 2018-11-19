`timescale 1ns / 1ps

module LFSR(clk, random);
    input clk;
    output [2:0] random;
 
    reg [32:1] register = 0;
    wire r_XNOR;

    always @(posedge clk)  begin
            register <= {register[32-1:1], r_XNOR};
    end
 
    assign r_XNOR = register[32] ^~ register[22] ^~ register[2] ^~ register[1];
 
  assign random = register[3:1];
 
endmodule