`timescale 1ns / 1ps

module blipgen(input in, input clk, input reset, output reg out);

    // declare buffer and inverted clk
    reg buffer;
    wire inv;
    assign inv = ~clk;
    
    // slow clock counter
    reg counter, slowinv;
    
    // slow clock
    always @ (posedge inv) begin
        if (reset) begin
            counter=0;
            slowinv=0;
        end
        else begin
            counter = counter +1;
            if (counter == 1) begin
                slowinv=~slowinv;
                counter = 0;
            end
        end
    end
    
    always @(posedge clk) begin
        if (in)
            buffer = 1;
        else
            buffer = 0;
    end
    
    always @(posedge buffer, posedge slowinv) begin
        if (slowinv)
            if (inv)
                out = 0;
        else
            out = 1;
    end
endmodule
