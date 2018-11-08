`timescale 1ns / 1ps

module display(video_on, pix_x, pix_y, graph_rgb);
    input video_on;
    input [9:0] pix_x, pix_y;
    output reg [11:0] graph_rgb;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // rgb multiplexing circuit
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    localparam WHITE    = 12'b111111111111;
    
    always @*
        if (video_on)
            graph_rgb = 0; // blank
        else
            graph_rgb = WHITE;

endmodule
