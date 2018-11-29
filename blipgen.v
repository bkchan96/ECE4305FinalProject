module blipgen(input in, input clk, input reset, output out);
    
    // declare register
    reg in_reg;
    
    // detect input
    always @(posedge clk, posedge reset)
        if (reset)
            in_reg <= 0;
        else
            in_reg <= in;
    
    // determine blip length
    assign out = in & ~in_reg;
    
endmodule