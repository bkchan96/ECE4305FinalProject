`timescale 1ns / 1ps

module top(clk, reset);
    input clk, reset;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    // Keyboard section
    //////////////////////////////////////////////////////////////////////////////////////////////////////
    
    wire rx_done_tick;
    wire [7:0] scan_code;
    wire key_left, key_right, key_up, key_down, key_game_reset, key_enter;
    
    // instantiate ps2 module
    ps2_rx u_ps2_rx(.clk(clk), .reset(reset), .ps2d(), .ps2c(), .rx_en(), .rx_done_tick(rx_done_tick), .dout(scan_code));
    
    // instantiate 
    kb_controller kb_left(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1C),
        .key(key_left));

    kb_controller kb_right(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h23),
        .key(key_right));

    kb_controller kb_up(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1D),
        .key(key_up));

    kb_controller kb_down(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h1B),
        .key(key_down));

    kb_controller kb_game_reset(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h2D),
        .key(key_game_reset));

    kb_controller kb_enter(.clk(clk), .reset(reset), .scan_done_tick(rx_done_tick), .scan_code(scan_code),
        .scan_code_read(8'h5A),
        .key(key_enter));

endmodule
